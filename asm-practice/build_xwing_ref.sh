#!/bin/bash
# X-Wing 레퍼런스(호스트) 빌드+테스트.
# 원본 Makefile은 -l25519를 CFLAGS(소스 앞)에 둬서 GNU ld에서 링크 실패 →
# make -n으로 컴파일 명령을 뽑아 라이브러리를 끝에 붙여 직접 실행한다.
set -e
cd ~/xwing/src/crypto_kem/xwing/ref

CMD=$(make -n test/test_xkem_functionality 2>&1 | grep -m1 'test_xkem_functionality\.c') || {
  echo "== make -n 출력에서 컴파일 라인을 못 찾음. 원본 출력:"
  make -n test/test_xkem_functionality 2>&1 | head -5
  exit 1
}
echo "== 컴파일 명령(요약): ${CMD:0:120} ... + -l25519"
eval "$CMD -l25519"
echo "== BUILD_OK"
./test/test_xkem_functionality
