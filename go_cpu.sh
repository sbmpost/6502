#!/bin/bash

verilator -CFLAGS -DVL_DEBUG=0 -cc cpu.v --exe cpu.cpp
make -j -C obj_dir -f Vcpu.mk && obj_dir/Vcpu
