import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { PrismaService } from './prisma/prisma.service';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ValidationPipe, VersioningType } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.enableVersioning({
    type: VersioningType.URI,
    defaultVersion: '1',
  });

  const config = new DocumentBuilder()
    .setTitle('Posts API')
    .setDescription(
      'This is a sample API for CodeYourFuture Cloud Module final project',
    )
    .setVersion('v1')
    .build();

  app.useGlobalPipes(new ValidationPipe());

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('/:version/docs', app, document);

  const prismaService = app.get(PrismaService);
  await prismaService.enableShutdownHooks(app);
  await app.listen(process.env.PORT || 4000);
}
bootstrap();
