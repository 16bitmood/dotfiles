#!/bin/bash

latest_file=$(ls ${HOME}/main/src/cfg/bkp/dconf | sort | tail -n1)
dconf dump / > ${latest_file}
