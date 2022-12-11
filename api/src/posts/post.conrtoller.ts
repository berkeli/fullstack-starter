import { Get, Param, Post, Body, Delete, Put } from '@nestjs/common';
import { PostService } from './post.service';
import { Post as PostModel } from '@prisma/client';
import {
  ApiCreatedResponse,
  ApiForbiddenResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { Controller } from '@nestjs/common';
import { PostEntity } from './post.entity';
import { CreatePostDto } from './createPostDto';

@ApiTags('posts')
@Controller('posts')
export class PostController {
  constructor(private readonly postService: PostService) {}
  @Get('/:id')
  @ApiOkResponse({ type: PostEntity })
  async getPostById(@Param('id') id: string): Promise<PostModel> {
    return this.postService.post({ id: Number(id) });
  }

  @Get()
  @ApiOkResponse({ type: PostEntity, isArray: true })
  async getPublishedPosts(): Promise<PostModel[]> {
    return this.postService.posts({
      where: { published: true },
    });
  }

  @Get('search/:searchString')
  @ApiOkResponse({ type: PostEntity, isArray: true })
  async getFilteredPosts(
    @Param('searchString') searchString: string,
  ): Promise<PostModel[]> {
    return this.postService.posts({
      where: {
        OR: [
          {
            title: { contains: searchString },
          },
          {
            content: { contains: searchString },
          },
        ],
      },
    });
  }

  @Post()
  @ApiCreatedResponse({
    description: 'The record has been successfully created.',
  })
  @ApiForbiddenResponse({ description: 'Forbidden.' })
  async createDraft(@Body() postData: CreatePostDto): Promise<PostModel> {
    const { title, content, authorEmail } = postData;
    return this.postService.createPost({
      title,
      content,
      author: {
        connect: { email: authorEmail },
      },
    });
  }

  @Put('publish/:id')
  @ApiOkResponse({ type: PostEntity })
  async publishPost(@Param('id') id: string): Promise<PostModel> {
    return this.postService.updatePost({
      where: { id: Number(id) },
      data: { published: true },
    });
  }

  @Delete('/:id')
  @ApiOkResponse({
    description: 'The record has been successfully deleted.',
  })
  async deletePost(@Param('id') id: string): Promise<PostModel> {
    return this.postService.deletePost({ id: Number(id) });
  }
}
