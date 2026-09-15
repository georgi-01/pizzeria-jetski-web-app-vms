import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { LoggerModule } from 'nestjs-pino';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { PasswordModule } from './password/password.module';
import { DatabaseInitializerModule } from './database-initializer/database-initializer.module';
import * as path from 'path';

const logDirectory = path.resolve(__dirname, '../../logs');
const isProduction = process.env.NODE_ENV === 'production';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),

    LoggerModule.forRoot({
      pinoHttp: {
        level: isProduction ? 'info' : 'debug',

        transport: {
          targets: [
            ...(isProduction
              ? []
              : [
                  {
                    target: 'pino-pretty',
                    level: 'debug',
                    options: {
                      colorize: true,
                      singleLine: true,
                      translateTime: 'SYS:standard',
                    },
                  },
                ]),

            {
              target: 'pino/file',
              level: 'info',
              options: {
                destination: path.join(logDirectory, 'application.log'),
                mkdir: true,
              },
            },

            {
              target: 'pino/file',
              level: 'error',
              options: {
                destination: path.join(logDirectory, 'error.log'),
                mkdir: true,
              },
            },
          ],
        },
      },
    }),

    PrismaModule,
    PasswordModule,
    DatabaseInitializerModule,
  ],

  controllers: [AppController],

  providers: [AppService],
})
export class AppModule {}
