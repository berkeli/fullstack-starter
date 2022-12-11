import { User } from '@prisma/client';
import { ApiProperty } from '@nestjs/swagger';
import { PostEntity } from 'src/posts/post.entity';

export class UserEntity implements User {
  @ApiProperty()
  id: number;

  @ApiProperty()
  name: string;

  @ApiProperty()
  email: string;

  @ApiProperty()
  posts: PostEntity[];
}
