import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  await prisma.user.create({
    data: {
      name: 'John Doe',
      email: 'johndoe@fakeemail.com',
      posts: {
        createMany: {
          data: [
            {
              title: 'Hello World',
              content: 'This is my first post',
              published: true,
            },
            {
              title: 'Lorem Ipsum',
              content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              published: true,
            },
            {
              title: 'Foo Bar',
              content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              published: true,
            },
          ],
        },
      },
    },
  });
}

main();
