#!/bin/bash
case "$1" in
  up)
    if [[ "$(uname)" == "Darwin" ]]; then
      # macOS: parse boot time from sysctl
      boot=$(sysctl -n kern.boottime | awk '{print $4}' | tr -d ',')
      now=$(date +%s)
      secs=$((now - boot))
      days=$((secs / 86400))
      hours=$(( (secs % 86400) / 3600 ))
      mins=$(( (secs % 3600) / 60 ))
      out=""
      [[ $days -gt 0 ]] && out="${days}d"
      [[ $hours -gt 0 ]] && out="${out}${hours}h"
      [[ $mins -gt 0 ]] && out="${out}${mins}m"
      printf "%s" "${out:-0m}"
    else
      uptime -p | sed 's/up //;s/ months\?/M/;s/ weeks\?/w/;s/ days\?/d/;s/ hours\?/h/;s/ minutes\?/m/;s/, //g'
    fi
    ;;
  cpu)
    if [[ "$(uname)" == "Darwin" ]]; then
      # macOS: use top in logging mode
      top -l 1 -n 0 2>/dev/null | awk '/CPU usage/{printf "%.0f%%", 100 - $7}'
    else
      # Linux: sample /proc/stat twice
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
    fi
    ;;
  dsk) df -h / | awk 'NR==2{printf "%s/%s", $3, $2}' ;;
esac
