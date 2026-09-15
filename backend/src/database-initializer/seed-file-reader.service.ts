import { Injectable } from '@nestjs/common';
import * as fs from 'fs/promises';
import * as path from 'path';

export interface SeedFile {
  order: number;
  fileName: string;
  filePath: string;
  sql: string;
}

@Injectable()
export class SeedFileReaderService {
  private readonly seedsDirectory = path.resolve(
    __dirname,
    '../../../../database/seeds',
  );

  async getSeedFiles(): Promise<SeedFile[]> {
    const filePaths = await this.findSqlFiles(this.seedsDirectory);

    const seedFiles = await Promise.all(
      filePaths.map(async (filePath) => {
        const fileName = path.basename(filePath);
        const order = this.getSeedOrder(fileName);
        const sql = await fs.readFile(filePath, 'utf8');

        return {
          order,
          fileName,
          filePath,
          sql,
        };
      }),
    );

    seedFiles.sort((a, b) => a.order - b.order);

    this.validateSeedFiles(seedFiles);

    return seedFiles;
  }

  private async findSqlFiles(directory: string): Promise<string[]> {
    const entries = await fs.readdir(directory, {
      withFileTypes: true,
    });

    const files: string[] = [];

    for (const entry of entries) {
      const entryPath = path.join(directory, entry.name);

      if (entry.isDirectory()) {
        files.push(...(await this.findSqlFiles(entryPath)));
        continue;
      }

      if (entry.isFile() && entry.name.endsWith('.sql')) {
        files.push(entryPath);
      }
    }

    return files;
  }

  private getSeedOrder(fileName: string): number {
    const match = /^(\d+)_.*\.sql$/.exec(fileName);

    if (!match) {
      throw new Error(
        `Invalid seed file name "${fileName}". Expected format: NNN_name.sql`,
      );
    }

    return Number(match[1]);
  }

  private validateSeedFiles(seedFiles: SeedFile[]): void {
    if (seedFiles.length === 0) {
      throw new Error(
        `No SQL seed files were found in "${this.seedsDirectory}".`,
      );
    }

    const orders = new Set<number>();

    for (const seedFile of seedFiles) {
      if (orders.has(seedFile.order)) {
        throw new Error(
          `Duplicate seed order ${seedFile.order} detected at "${seedFile.fileName}".`,
        );
      }

      orders.add(seedFile.order);
    }
  }
}
