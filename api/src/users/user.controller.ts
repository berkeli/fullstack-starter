import { User as UserModel } from '@prisma/client';
import { Body, Controller, Post } from '@nestjs/common';
import { ApiCreatedResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from './user.service';
import { CreateUserDto } from './createUserDto';

@ApiTags('users')
@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}
  @Post()
  @ApiCreatedResponse({
    description: 'The user has been successfully created.',
  })
  async signupUser(@Body() userData: CreateUserDto): Promise<UserModel> {
    return this.userService.createUser(userData);
  }
}
