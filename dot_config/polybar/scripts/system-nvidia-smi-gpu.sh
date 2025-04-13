#!/bin/sh

gpu=`nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits`
printf "GPU %2d%%" "$gpu"
