# English LNCS draft

This directory contains the English draft for the new LNCS paper structure.
It is not the canonical manuscript; substantive edits should first be checked
against `../ko/main.tex` and the evidence listed in `../README.md`.

## Contents

- `main.tex` and `main.pdf`: English draft and rendered review copy
- `references.bib`: bibliography used by this draft
- `data/`: tabular inputs for the publication figures
- `build_assets.py`: dependency-free SVG/EPS generator
- `assets/`: generated SVG, EPS, PDF, and PNG figures
- `TRANSLATION_CRITERIA.md`: translation and claim-preservation rules

## Rebuild

```powershell
python .\build_assets.py
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

The author and institute fields are placeholders until submission metadata is
finalized.
