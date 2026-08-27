#!/bin/bash
A="$HOME/slothy/slothy/targets/arm_v81m/arch_v81m.py"
for c in vldrw vstrw vshl vsri veor vbic vorr vmov_imm; do
  echo "=== $c ==="
  awk "/^class ${c}\(/{f=1} f{print} f&&/pattern/{exit}" "$A" | grep pattern
done
