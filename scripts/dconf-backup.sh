#!/bin/bash

dirname=${HOME}/main/src/cfg/bkp/dconf
filename="$(date +%F).txt"
dconf dump / > ${dirname}/${filename}
