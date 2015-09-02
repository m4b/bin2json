#!/bin/bash

output="$(./bin2json.native -m bin/linux/other)"

diff="$(diff -q <(echo "$output") "output/other.m.json")"

result=$?

if [[ -z "$diff"  &&  $result -eq 0 ]]
then
    echo "PASS"
else
    echo "FAIL:";
    echo $diff
fi
