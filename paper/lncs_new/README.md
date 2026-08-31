# New LNCS paper assets

This directory contains publication assets for the new paper structure in
../LNCS_신규_초안.md. It does not modify or replace the existing ko/main.tex.

## Canonical inputs

- data/final_performance.tsv: direct same-ELF Reference--Integrated headline
- data/leave_one_out.tsv: leave-one-out diagnostic for the six-transform implementation
- data/stage2_results.tsv: diagnostic for the two additional X25519 transformations
- build_assets.py: deterministic vector-figure generator

The intermediate percentages are diagnostic and must not be added to the
direct Reference--Integrated headline.

## Figures

- assets/fig01_xwing_optimization_map.pdf: the eight retained transformations
- assets/fig02_adoption_pipeline.pdf: micro-to-end-to-end adoption gates
- assets/fig03_paired_inversion.pdf: independent versus paired inversion
- assets/fig04_final_performance.pdf: normalized final Reference--Integrated result

PDF is the publication format. Matching SVG/EPS files are editable vector
sources and PNG files are review previews. The figures directory contains
ready-to-input LNCS figure environments and captions.

## Tables

- tables/tab01_transform_scope.tex
- tables/tab02_final_direct.tex
- tables/tab03_leave_one_out.tex
- tables/tab04_stage2.tex
- tables/tab05_candidate_gates.tex
- tables/tab06_resource_tradeoff.tex

The table fragments assume the LNCS paper already loads booktabs and tabularx.
The all_tables.tex file is a convenience index; final placement should use the
individual fragments in the relevant sections.

## LNCS smoke test

- asset_smoke_test.tex includes all four figures and all six tables with the
  bundled LNCS 2.26 class.
- asset_smoke_test.pdf is the rendered six-page layout check.
- The checked build has no overfull box, undefined control sequence, unresolved
  reference, or figure-PDF compatibility warning.

## Rebuild

From paper/lncs_new:

~~~
python build_assets.py
~~~

The script has no Python package dependency. It writes SVG/EPS directly and
uses MiKTeX Ghostscript, when available, for PDF and PNG conversion.
