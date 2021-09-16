This repository controls the periodic copying of translations from gpde/gpfr/gpit into gpch (using [GreenpeaceSchweiz/weblatetools](https://github.com/GreenpeaceSchweiz/weblatetools))

Main components:
- `/.github/workflows/copy.yml` defines the scheduled github action that runs the script and commits the updated translation and log files afterwards.
- `copy.R` is the script defining how to copy translations.
- log files: `log.csv` (summary, one line per language copied) and files in `/logs` (detailed, one file per language copied)
- Folders `/de`, `/it`, `/fr`: The translation files. These are not relevant but tracked for potential debugging reasons.

## Warning: This repo contains the private Weblate access token. Repo must remain private!
