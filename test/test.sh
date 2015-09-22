#!/bin/bash

output="$(./bin2json.native -m -b -c bin/other)"

diff="$(diff -q <(echo "$output") "output/other.m.b.c.json")"

result=$?

if [[ -z "$diff"  &&  $result -eq 0 ]]
then
    echo "PASS"
else
    echo "FAIL:";
    echo $diff
fi
