#!/bin/bash

/usr/local/bin/docker-entrypoint.sh mongod &

## hacky
sleep 10
node marmalade.js
