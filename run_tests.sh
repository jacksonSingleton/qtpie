#!/bin/sh
#
# **do not add tests directly to this file**
# run ./create_test.sh <file> <library 1> ... <library n> instead
# ----------------------------------------------------------------

echo "Running tests..."

echo "main.zig"
echo "---------"
zig test src/main.zig -l xml2
echo "--------"
