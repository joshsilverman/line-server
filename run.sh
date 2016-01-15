#!/bin/bash -e

printf "Reseting database...\n\n"
bundle exec rake db:reset

# printf "Generating sample file...\n\n"
# LINE_COUNT=200
# WORDS_PER_LINE=100
# rake data:generate['tmp/data/sample.txt',$LINE_COUNT,$WORDS_PER_LINE]

printf "Preprocessing data...\n\n"
# rake preprocessor:preprocess['tmp/data/sample.txt']

filename="$1"
rake preprocessor:preprocess[$filename]

rails s