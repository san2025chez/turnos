FROM node:12

WORKDIR /artillery
COPY ./docker/artillery/package.json package.json
RUN npm install
COPY ./test/artillery ./
ENTRYPOINT [ "npm" ]

