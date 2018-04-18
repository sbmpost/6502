#!/bin/bash

verilator -CFLAGS -DVL_DEBUG=0 -cc LogisimToplevelShell.v --exe shell.cpp
make -j -C obj_dir -f VLogisimToplevelShell.mk && obj_dir/VLogisimToplevelShell
