import { Box, Heading, Text } from "@chakra-ui/react";
import React from "react";

type Props = {
  post: any;
};

const PostPreview = ({ post }: Props) => {
  return (
    <Box p="4">
      <Heading as="h3">{post.title}</Heading>
      <Text>{post.content}</Text>
    </Box>
  );
};

export default PostPreview;
