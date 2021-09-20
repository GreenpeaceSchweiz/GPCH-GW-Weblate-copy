library(weblatetools)

# copyTranslations() stores the translation files and creates log files.
# Choose an appropriate working directory. 
# setwd("~/myproject")

# Initialize some base parameters. "to.project" is set here instead of in 
# copyTranslations() or postFile() to avoid mistakenly writing to the wrong 
# project.
setup(api.url = "https://translate.getopensocial.com/api/",
      token = Sys.getenv("WEBLATE_PAT"),
      to.project = "gpch")

# Working with the components from the destination project is recommended.
# If, during the copy process, you try to get a component that does not exist in
# the source project, it will simply be skipped.
slugs <- getComponents("gpch")$slugs

# If running this from manually triggered GH action: Option to copy
# only one component, as a test.
if(Sys.getenv("GHACTION_TESTING") == "TRUE"){
      slugs <- "address"
}

Sys.getenv("GHACTION_TESTING")
slugs

if(TRUE == FALSE) {
# COPY
cat("=== GERMANY ===========================\n")

new_de <- copyTranslations(components = slugs,
                           to.language = "de_CH",
                           from.project = "gpde",
                           from.language = "de",
#                          filter = "filter this translation",
                           replace = as.data.frame(cbind(pattern = c("ß"),
                                                         replace = c("ss"))),
                           verbose = TRUE)


cat("=== FRANCE ===========================\n")

new_fr <- copyTranslations(components = slugs,
                           to.language = "fr_CH",
                           from.project = "gpfr",
                           from.language = "fr",
                           filter = "weGreen",
#                          replace = as.data.frame(cbind(pattern = c("ß"),
#                                                        replace = c("ss"))),
                           verbose = TRUE)


cat("=== ITALY ===========================\n")

new_it <- copyTranslations(components = slugs,
                           to.language = "it_CH",
                           from.project = "gpit",
                           from.language = "it",
                           filter = "Standup",
#                          replace = as.data.frame(cbind(pattern = c("ß"),
#                                                        replace = c("ss"))),
                           verbose = TRUE)

# Save result for logging
Sys.setenv(NEW_DE = new_de, NEW_FR = new_fr, NEW_IT = new_it)
}
