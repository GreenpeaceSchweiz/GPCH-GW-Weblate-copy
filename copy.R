library(weblatetools)

# copyTranslations() stores the translation files and creates log files.
# Choose an appropriate working directory. 
# setwd("~/myproject")

# Initialize some base parameters. "to.project" is set here instead of in 
# copyTranslations() or postFile() to avoid mistakenly writing to the wrong 
# project.
setup(api.url = "https://translate.getopensocial.com/api/",
      token = "E41b6PiEbY37FUhSxtjg0iEqoybyIddmrfNtzGfj",
      to.project = "gpch")

# Working with the components from the destination project is recommended.
# If, during the copy process, you try to get a component that does not exist in
# the source project, it will simply be skipped.
components <- getComponents("gpch")

copyTranslations(components = components$slugs,
                 to.language = "de_CH",
                 from.project = "gpde",
                 from.language = "de",
#                filter = "filter this translation",
                 replace = as.data.frame(cbind(pattern = c("ß"),
                                               replace = c("ss"))),
                 verbose = TRUE)
