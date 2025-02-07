#!/bin/bash

echo "Starting API Web Server"
mkdir -p /usr/src/app/tmp/pids
bundle exec rails server -b 0.0.0.0 -p 3000
echo "Exit status: $?"