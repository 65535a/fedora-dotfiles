#!/bin/bash
ps -eo comm,%cpu --sort=-%cpu --no-headers | head -5 | \
    awk '{printf "{\"name\":\"%s\",\"val\":\"%s\"},", $1, $2}' | \
    sed 's/,$//' | awk '{print "["$0"]"}'
