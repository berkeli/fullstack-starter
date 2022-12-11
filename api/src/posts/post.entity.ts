import { Post } from '@prisma/client';
import { ApiProperty } from '@nestjs/swagger';
import { UserEntity } from 'src/users/user.entity';

export class PostEntity implements Post {
  @ApiProperty()
  id: number;

  @ApiProperty()
  title: string;

  @ApiProperty()
  content: string;

  @ApiProperty()
  published: boolean;

  @ApiProperty()
  authorId: number;

  @ApiProperty()
  author: UserEntity;
}
