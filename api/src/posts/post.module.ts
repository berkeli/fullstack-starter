import { Module } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { PostController } from './post.conrtoller';
import { PostService } from './post.service';

@Module({
  providers: [PostService, PrismaService],
  controllers: [PostController],
})
export class PostModule {}
