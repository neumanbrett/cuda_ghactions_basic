#!/bin/bash

source $PBS_JOBDIR/casper-a100.cfg

nvcc hello_world.cu -o hello_world &> compile.log
