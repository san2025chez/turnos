FROM node:14-alpine

RUN mkdir mocks
RUN mkdir util
RUN mkdir util/scripts

# REQUIRED FILES
COPY ./package.json .
COPY ./package-lock.json .
COPY ./versatec-mock.js  .
COPY ./util/mock-assembler.ts ./util
COPY ./util/util.ts ./util
COPY ./util/scripts/process-runner.sh ./util/scripts

# REQUIRED DIRECTORIES
COPY ./mocks ./mocks

RUN touch config.json

# Do not run as root.
RUN adduser --shell /bin/sh --disabled-password --gecos "" mockoon
RUN chown -R mockoon config.json
RUN chown -R mockoon package.json
RUN npm i

RUN chown -R mockoon ./util/scripts/process-runner.sh
RUN chmod +x ./util/scripts/process-runner.sh
USER mockoon

RUN npx ts-node /util/mock-assembler.ts /mocks config.json 

ENTRYPOINT ["./util/scripts/process-runner.sh","."]

# Usage: docker run -p <host_port>:<container_port> mockoon-test