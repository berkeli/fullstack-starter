import { Center, Heading, VStack } from '@chakra-ui/react';
import Head from 'next/head';
import PostPreview from '../components/PostPreview';

export default function Home({ posts }: { posts: [any] }) {
  console.log(posts);
  return (
    <div>
      <Head>
        <title>CYF Cloud Module final project</title>
        <meta name="description" content="CYF Cloud Module final project submission" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
        <VStack p="4" px="24">
          <Heading as="h1" mb="3">
            Posts
          </Heading>
          {posts.map((post) => (
            <PostPreview key={post.id} post={post} />
          ))}
        </VStack>
      </main>
    </div>
  );
}

export async function getServerSideProps() {
  try {
    const res = await fetch(`${process.env.API_URL}/posts`);

    const posts = await res.json();
    return {
      props: {
        posts,
      },
    };
  } catch (error) {
    console.log(error);
    return {
      props: {
        posts: [],
      },
    };
  }
}
