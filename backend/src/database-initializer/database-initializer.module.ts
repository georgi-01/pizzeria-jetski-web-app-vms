import { Module } from '@nestjs/common';
import { DatabaseInitializerService } from './database-initializer.service';
import { SeedFileReaderService } from './seed-file-reader.service';

@Module({
  providers: [
    DatabaseInitializerService,
    SeedFileReaderService,
  ],
})
export class DatabaseInitializerModule {}
