#!/bin/bash
ps -eo comm,%mem --sort=-%mem --no-headers | head -5 | \
    awk '{printf "{\"name\":\"%s\",\"val\":\"%s\"},", $1, $2}' | \
    sed 's/,$//' | awk '{print "["$0"]"}'
