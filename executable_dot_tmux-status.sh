#!/bin/bash
case "$1" in
  up)  uptime -p | sed 's/up //;s/ months\?/M/;s/ weeks\?/w/;s/ days\?/d/;s/ hours\?/h/;s/ minutes\?/m/;s/, //g' ;;
  cpu)
    # Sample /proc/stat twice to compute current CPU usage (delta-based)
    read _ u1 n1 s1 i1 w1 irq1 sirq1 _ < /proc/stat
    sleep 0.5
    read _ u2 n2 s2 i2 w2 irq2 sirq2 _ < /proc/stat
    total1=$((u1+n1+s1+i1+w1+irq1+sirq1))
    total2=$((u2+n2+s2+i2+w2+irq2+sirq2))
    idle1=$((i1+w1))
    idle2=$((i2+w2))
    dt=$((total2-total1))
    di=$((idle2-idle1))
    if [ "$dt" -gt 0 ]; then
      awk -v dt="$dt" -v di="$di" 'BEGIN{printf "%.0f%%", (dt-di)*100/dt}'
    else
      printf "0%%"
    fi
    ;;
  dsk) df -h / | awk 'NR==2{printf "%s/%s", $3, $2}' ;;
esac
