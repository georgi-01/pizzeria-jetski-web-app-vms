import { NestFactory } from '@nestjs/core';
import { Logger } from 'nestjs-pino';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';

import { writeFileSync } from 'fs';
import { join } from 'path';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    bufferLogs: true,
  });

  app.useLogger(app.get(Logger));

  app.setGlobalPrefix('api');

  const isProduction = process.env.NODE_ENV === 'production';

  if (!isProduction) {
    const swaggerConfig = new DocumentBuilder()
      .setTitle('Pizzeria Jetski API')
      .setDescription('API documentation for Pizzeria Jetski Web App')
      .setVersion('0.0.2')
      .build();

    const swaggerDocument = SwaggerModule.createDocument(
      app,
      swaggerConfig,
    );

    const openApiPath = join(
      process.cwd(),
      'docs',
      'openapi.json',
    );

    writeFileSync(
      openApiPath,
      JSON.stringify(swaggerDocument, null, 2),
      'utf-8',
    );

    app.getHttpAdapter().get('/api/openapi.json', (_req, res) => {
      res.json(swaggerDocument);
    });

    SwaggerModule.setup(
      'api/docs',
      app,
      swaggerDocument,
    );
  }

  await app.listen(process.env.PORT ?? 3000);
}

bootstrap();
