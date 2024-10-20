#!/bin/bash

# CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
# CPU_INFO=$(ps -eo pcpu,user)
# CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
# CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
#
# CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"
#
# MEM_INFO=$(ps -eo %mem)
#
# MEM_SYS=$(echo $MEM_INFO | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum}" | awk '{printf "%.0f\n", $1*100}')

# sketchybar --set $NAME
