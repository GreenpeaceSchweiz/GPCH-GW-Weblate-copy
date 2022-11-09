This repository controls the periodic copying of translations from open-social, gpde, gpfr, gpit into gpch (using [GreenpeaceSchweiz/weblatetools](https://github.com/GreenpeaceSchweiz/weblatetools))

Main components:
- `/.github/workflows/copy.yml` defines the scheduled github action that runs the script and commits the updated translation and log files afterwards.
- `copy.R` is the script defining how to copy translations.
- Weblate API key, stored as a GitHub Secret with the name `WEBLATE_PAT` (in repository settings > secrets > actions)
- log files: `log.csv` (summary, one line per language copied) and files in `/logs` (detailed, one file per language copied)
- Folders `/de`, `/it`, `/fr`: The translation files. These are not relevant but tracked for potential debugging reasons.

If you want to fork this project:
- Don't forget to provide your own Weblate API key. This is of course not copied when you fork the project.
- Make sure to specify your own Weblate project in the `setup()` call in `copy.R`. Otherwise you risk changing someone else's translations.
