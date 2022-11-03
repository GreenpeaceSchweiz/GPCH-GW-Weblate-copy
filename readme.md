This repository controls the periodic copying of translations from open-social, gpde, gpfr, gpit into gpch (using [GreenpeaceSchweiz/weblatetools](https://github.com/GreenpeaceSchweiz/weblatetools))

Main components:
- `/.github/workflows/copy.yml` defines the scheduled github action that runs the script and commits the updated translation and log files afterwards.
- `copy.R` is the script defining how to copy translations.
- log files: `log.csv` (summary, one line per language copied) and files in `/logs` (detailed, one file per language copied)
- Folders `/de`, `/it`, `/fr`: The translation files. These are not relevant but tracked for potential debugging reasons.

If you want to fork this project, note that authentication with Weblate happens through a personal access token that needs to be stored as a Github secret in the repository with the name `WEBLATE_PAT`.
