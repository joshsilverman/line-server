#!/bin/bash -e

printf "Building...\n\n"

printf "Bundling...\n\n"
gem install bundler
bundle

printf "Running tests...\n\n"
bundle exec rspec

printf "Build complete\n\n"