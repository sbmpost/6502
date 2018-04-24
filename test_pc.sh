#!/bin/bash

rm obj_dir/* 2> /dev/null
verilator -Wall -CFLAGS -DVL_DEBUG=0 -cc pc.v --exe pc.cpp
make -j -C obj_dir -f Vpc.mk && obj_dir/Vpc
