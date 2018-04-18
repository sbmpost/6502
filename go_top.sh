#!/bin/bash

verilator -CFLAGS -DVL_DEBUG=0 -cc top.v --exe top.cpp
make -j -C obj_dir -f Vtop.mk && obj_dir/Vtop
