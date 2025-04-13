#!/bin/sh

total=`nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits`
used=`nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits`
utilization=$(echo "100 * $used / $total" | bc)
printf "VRAM %2d%%" "$utilization"
