import Head from "next/head";

export default function Home({ posts }: { posts: [any] }) {
  console.log(posts);
  return (
    <div>
      <Head>
        <title>CYF Cloud Module final project</title>
        <meta name="description" content="CYF Cloud Module final project submission" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main></main>
    </div>
  );
}

export async function getServerSideProps() {
  const res = await fetch(`${process.env.API_URL}/posts`);
  const posts = await res.json();
  return {
    props: {
      posts,
    },
  };
}
