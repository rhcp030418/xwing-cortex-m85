#!/bin/bash
A="$HOME/slothy/slothy/targets/arm_v81m/arch_v81m.py"
for c in veor_nodt vbic_nodt vorr; do
  echo "=== $c ==="
  awk "/^class ${c}\(/{f=1} f{print} f&&/pattern/{exit}" "$A" | grep pattern
done
echo "--- all v-bitwise nodt ---"
grep -nE "^class v(eor|bic|orr|and)" "$A"
