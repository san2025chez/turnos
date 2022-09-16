#!/bin/sh

echo "Running node app located on '${1}/versatec-mock.js' directory"
node  "${1}/versatec-mock.js" &

echo "Running mock"
npx "/node_modules/@mockoon/cli/bin/run"  start  --hostname  0.0.0.0  --daemon-off  --data  config.json  --container

