#!/bin/bash
# CMSIS_6 헤더 동봉 스크립트 (1회용 — cmsis/ 가 이미 있으면 재실행 불필요)
# 출처: github.com/ARM-software/CMSIS_6 (Apache-2.0), 파일 원본 그대로 복사
set -e
cd "$(dirname "$0")"
mkdir -p cmsis/m-profile
B=https://raw.githubusercontent.com/ARM-software/CMSIS_6/main/CMSIS/Core/Include
for f in core_cm85.h cmsis_version.h cmsis_compiler.h \
         m-profile/armv8m_pmu.h m-profile/armv81m_pac.h \
         m-profile/armv7m_cachel1.h m-profile/armv8m_mpu.h \
         m-profile/cmsis_gcc_m.h; do
  curl -sfL "$B/$f" -o "cmsis/$f"
  echo "OK $f"
done
