import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PostModule } from './posts/post.module';
import { UserModule } from './users/user.module';

@Module({
  imports: [UserModule, PostModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
