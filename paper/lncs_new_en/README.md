# English LNCS manuscript

This directory contains the current English manuscript and its publication
assets. The repository [evaluation guide](../../EVALUATION.md) maps its claims
to frozen board evidence and states the reproduction limits.

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

The PDF author and institute fields are intentionally anonymous. The public
GitHub repository itself is not anonymous because its owner and history identify
the author.
