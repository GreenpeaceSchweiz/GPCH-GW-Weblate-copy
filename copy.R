library(weblatetools)

# copyTranslations() stores the translation files and creates log files.
# Choose an appropriate working directory.
# setwd("~/myproject")

# Initialize some base parameters. "to.project" is set here instead of in
# copyTranslations() or postFile() to avoid mistakenly writing to the wrong
# project.
setup(api.url = "https://translate.getopensocial.com/api/",
      token = Sys.getenv("WEBLATE_PAT"),
      to.project = "gpch",
      debug = Sys.getenv("GHACTION_DEBUG"))

# Working with the components from the destination project is recommended.
# If, during the copy process, you try to get a component that does not exist in
# the source project, it will simply be skipped.
slugs <- getComponents("gpch")$slugs

# If running this from manually triggered GH action: Option to copy
# only one specified component, as a test.
if(Sys.getenv("GITHUB_EVENT_NAME") == "workflow_dispatch" &&
   Sys.getenv("GHACTION_CUSTOM_SLUG") != ""){
   cat(paste("GHACTION_CUSTOM_SLUG: ", Sys.getenv("GHACTION_CUSTOM_SLUG"),"\n"))
   slugs <- Sys.getenv("GHACTION_CUSTOM_SLUG")
}

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

# For commit message
system(paste("echo 'new_tl_count=", (new_de + new_fr + new_it),"' >> $GITHUB_ENV", sep =""))
