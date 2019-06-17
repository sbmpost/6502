#!/bin/bash

cat 6502_functional_test.bin | xxd -c1 | cut -c5- | sed "s/\(.*\): \(.*\).../s_mem_contents[16'h\1] = 8\'h\2;/g" > ./memory.txt
