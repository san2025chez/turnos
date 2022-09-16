FROM node:12

WORKDIR /app
COPY ./package.json package.json
COPY ./package-lock.json package-lock.json
COPY ./lib ./lib
RUN npm install
COPY ./tsconfig.json tsconfig.json
COPY ./tsconfig.build.json tsconfig.build.json
COPY ./dev ./dev
COPY ./src ./src
RUN node ./lib/dto-generator.js
RUN npm run build 
# RUN rm -rf src \
# & rm -rf package.json
RUN find ./dev -name '*.yaml' -exec cp -prv --parents {} './dist' ';'
RUN find ./src -name '*.yaml' -exec cp -prv --parents {} './dist' ';'
WORKDIR /app/dist
ENTRYPOINT [ "node" ]
CMD [ "dev/main.js" ]
