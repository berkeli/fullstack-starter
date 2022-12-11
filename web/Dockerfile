FROM node:18

ENV NODE_ENV=development
WORKDIR /web

COPY package.json ./
COPY yarn.lock ./

RUN yarn
