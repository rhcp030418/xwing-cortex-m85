#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "$0")" && pwd)
artifact_dir="$script_dir/../measure-harness/artifacts/2026-08-28_expCN_cp_sat_repro"
slothy_root=${SLOTHY_ROOT:-/home/cnscjs1395/slothy}
python_bin=${SLOTHY_PYTHON:-$slothy_root/venv/bin/python}

mkdir -p "$artifact_dir"
cd "$script_dir"

for run in 1 2; do
    PYTHONHASHSEED=0 SLOTHY_ROOT="$slothy_root" \
        "$python_bin" run_exp_bmid.py exp_bmid.s \
        "$artifact_dir/exp_bmid_repro${run}.s" \
        2>&1 | tee "$artifact_dir/exp_bmid_repro${run}.log"
done

file_hash() {
    sha256sum "$1" | awk '{print $1}'
}
{
    printf '%s  %s\n' "$(file_hash exp_bmid.s)" 'slothy-2stream/exp_bmid.s'
    printf '%s  %s\n' "$(file_hash run_exp_bmid.py)" 'slothy-2stream/run_exp_bmid.py'
    printf '%s  %s\n' "$(file_hash solver_repro.py)" 'slothy-2stream/solver_repro.py'
    printf '%s  %s\n' \
        "$(file_hash "$artifact_dir/exp_bmid_repro1.s")" \
        'measure-harness/artifacts/2026-08-28_expCN_cp_sat_repro/exp_bmid_repro1.s'
    printf '%s  %s\n' \
        "$(file_hash "$artifact_dir/exp_bmid_repro2.s")" \
        'measure-harness/artifacts/2026-08-28_expCN_cp_sat_repro/exp_bmid_repro2.s'
} > "$artifact_dir/sha256.txt"

cmp "$artifact_dir/exp_bmid_repro1.s" "$artifact_dir/exp_bmid_repro2.s"
grep -F '"solver_num_workers": 1' "$artifact_dir/exp_bmid_repro1.log" >/dev/null
grep -F '"solver_random_seed": 42' "$artifact_dir/exp_bmid_repro1.log" >/dev/null
grep -F '"python_hash_seed": "0"' "$artifact_dir/exp_bmid_repro1.log" >/dev/null
grep -F 'OR-Tools CP-SAT v9.15.6755, 1 threads' \
    "$artifact_dir/exp_bmid_repro1.log" >/dev/null

echo 'EXP_CN_REPRO_PASS output_byte_identical=1 seed=42 workers=1'
