#!/bin/bash

FILE=$1

echo "Creating test for $FILE..."
echo "Linking libs ${@:2}"

echo "" >> run_tests.sh
echo "echo \"$FILE\"" >> run_tests.sh
echo "echo \"---------\"" >> run_tests.sh
echo "zig test $FILE -l ${@:2}" >> run_tests.sh
echo "echo \"---------\"" >> run_tests.sh
