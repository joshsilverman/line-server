#!/bin/bash -e

printf "Building...\n\n"

printf "Bundling...\n\n"
gem install bundler
bundle

printf "Generating sample file...\n\n"
LINE_COUNT=100000
WORDS_PER_LINE=100
rake data:generate['tmp/data/sample.txt',$LINE_COUNT,$WORDS_PER_LINE]

printf "Preprocessing sample data...\n\n"
rake preprocessor:preprocess['tmp/data/sample.txt']

printf "Build complete\n\n"