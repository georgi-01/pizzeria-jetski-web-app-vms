import { Injectable, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PinoLogger } from 'nestjs-pino';

import { PrismaService } from '../prisma/prisma.service';
import {
  SeedFile,
  SeedFileReaderService,
} from './seed-file-reader.service';

const CURRENT_SEED_VERSION = 2;

@Injectable()
export class DatabaseInitializerService implements OnModuleInit {
  private readonly currentSeedVersion = CURRENT_SEED_VERSION;

  constructor(
    private readonly prisma: PrismaService,
    private readonly configService: ConfigService,
    private readonly logger: PinoLogger,
    private readonly seedFileReader: SeedFileReaderService,
  ) {
    this.logger.setContext(DatabaseInitializerService.name);
  }

  async onModuleInit(): Promise<void> {
    await this.initializeDatabase();
  }

  private async initializeDatabase(): Promise<void> {
    this.logger.info('Checking database initialization state...');

    const initialization =
      await this.prisma.database_initialization.findUnique({
        where: {
          id: true,
        },
      });

    if (
      initialization?.initialized === true &&
      initialization.seed_version === this.currentSeedVersion
    ) {
      this.logger.info(
        {
          seedVersion: initialization.seed_version,
          initializedAt: initialization.initialized_at,
          environment: initialization.environment,
        },
        'Database is already initialized. Skipping seed.',
      );

      return;
    }

    if (
      initialization?.initialized === true &&
      initialization.seed_version > this.currentSeedVersion
    ) {
      throw new Error(
        `Database seed version ${initialization.seed_version} is newer than application seed version ${this.currentSeedVersion}.`,
      );
    }

    const environment = this.getEnvironment();
    const seedFiles = await this.seedFileReader.getSeedFiles();

    this.logger.info(
      {
        seedVersion: this.currentSeedVersion,
        environment,
        seedFileCount: seedFiles.length,
      },
      'Database initialization required. Starting seed...',
    );

    try {
      await this.prisma.$transaction(
        async (tx) => {
          for (const seedFile of seedFiles) {
            await this.executeSeedFile(tx, seedFile);
          }

          await tx.database_initialization.upsert({
            where: {
              id: true,
            },
            create: {
              id: true,
              seed_version: this.currentSeedVersion,
              initialized: true,
              initialized_at: new Date(),
              environment,
            },
            update: {
              seed_version: this.currentSeedVersion,
              initialized: true,
              initialized_at: new Date(),
              environment,
            },
          });
        },
        {
          maxWait: 10_000,
          timeout: 120_000,
        },
      );

      this.logger.info(
        {
          seedVersion: this.currentSeedVersion,
          environment,
        },
        'Database initialization completed successfully.',
      );
    } catch (error) {
      this.logger.error(
        {
          err: error,
          seedVersion: this.currentSeedVersion,
          environment,
        },
        'Database initialization failed. Transaction rolled back.',
      );

      throw error;
    }
  }

  private async executeSeedFile(
    tx: Parameters<PrismaService['$transaction']>[0] extends (
      arg: infer T,
    ) => unknown
      ? T
      : never,
    seedFile: SeedFile,
  ): Promise<void> {
    const sql = seedFile.sql.trim();

    if (!sql) {
      throw new Error(
        `Seed file "${seedFile.fileName}" is empty.`,
      );
    }

    this.logger.info(
      {
        order: seedFile.order,
        fileName: seedFile.fileName,
      },
      'Executing seed file.',
    );

    try {
      await (tx as any).$executeRawUnsafe(sql);
    } catch (error) {
      throw new Error(
        `Seed failed in ${seedFile.fileName}.\n${
          error instanceof Error ? error.message : String(error)
        }`,
        {
          cause: error,
        },
      );
    }
  }

  private getEnvironment(): 'DEVELOPMENT' | 'PRODUCTION' {
    const nodeEnvironment =
      this.configService.get<string>('NODE_ENV') ?? 'development';

    const environment = nodeEnvironment.toUpperCase();

    if (
      environment === 'DEVELOPMENT' ||
      environment === 'PRODUCTION'
    ) {
      return environment;
    }

    throw new Error(
      `Invalid NODE_ENV '${nodeEnvironment}'. Expected DEVELOPMENT or PRODUCTION.`,
    );
  }
}
