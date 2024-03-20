#!/bin/bash
# entrypoint.sh

# Install gem dependencies
bundle install

# Install node packages
npm install

# Pre-Compile Assets
rails assets:precompile

# Migrate database
rails db:create db:migrate db:seed

# Remove servier .pid file
rm tmp/pids/server.pid

# Start rails server
rails s -b 0.0.0.0

# Start a bash console
/bin/bash
