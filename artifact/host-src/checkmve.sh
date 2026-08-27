#!/bin/bash
A="$HOME/slothy/slothy/targets/arm_v81m/arch_v81m.py"
for m in vldrw vstrw vshl vsri veor vbic vorr vmov_imm; do
  printf "%s: " "$m"
  grep -cE "^class ${m}\b" "$A"
done
echo "--- vldrw variants ---"
grep -nE "^class vldrw|^class vstrw" "$A"
