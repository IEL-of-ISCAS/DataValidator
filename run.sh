#!/usr/bin/env bash
#
# Validate input data

find data -name '*.txt' -print0 | xargs -0 -I file ruby validator.rb file
