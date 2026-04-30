#!/bin/bash
case "$1" in
  up)  uptime -p | sed 's/up //;s/ months\?/M/;s/ weeks\?/w/;s/ days\?/d/;s/ hours\?/h/;s/ minutes\?/m/;s/, //g' ;;
  cpu) awk '/^cpu / {usage=100-($5*100/($2+$3+$4+$5+$6+$7+$8))} END {printf "%.0f%%", usage}' /proc/stat ;;
  dsk) df -h / | awk 'NR==2{printf "%s/%s", $3, $2}' ;;
esac
