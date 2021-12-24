# When developing GPCH-GW-weblate-copy, some translations were wrongly set to "NA"
# when there was no translation available. They have since been replaced with "".
# This however also counts as a translation, and thus blocks new translations
# from being uploaded when "copy.R" is being run.
# The script here allows to check if a new translation would be available for
# any of these "".

library(weblatetools)

setup(api.url = "https://translate.getopensocial.com/api",
      token = readLines("token.txt"),
      to.project = "gpch")


components <- c("disable-user-1-edit",
                "editor-advanced-link",
                "google-analytics",
                "language-access",
                "layout-builder-restrictions",
                "lazy",
                "login-tracker",
                "oauth2-client",
                "openapi",
                "openapi-ui",
                "openapi-ui-redoc",
                "poll",
                "redis",
                "role-delegation",
                "taxonomy-access-fix",
                "update-helper",
                "social-advanced-image",
                "social-engagement",
                "social-newsletter",
                "social-paragraphs-user-roles",
                "social-search-solr",
                "social-spam-prevention",
                "social-wootric",
                "social-saas-analytics",
                "social-saas-permissions",
                "gpi-validation")


# Get State of GPCH French
copyTranslations(components,
                 to.language = "fr_CH",
                 from.project = "gpch",
                 from.language = "fr_CH",
                 verbose = TRUE,
                 download = TRUE,
                 upload = FALSE)

# Get GPFR French
copyTranslations(components,
                 to.language = "fr_CH",
                 from.project = "gpfr",
                 from.language = "fr",
                 verbose = TRUE,
                 download = TRUE,
                 upload = FALSE)

# Merge France French into Swiss French
results <- data.frame(matrix(nrow = 0, ncol = 2))
for (slug in components) {
  fr    <- readFile(slug, "fr")
  fr_CH <- readFile(slug, "fr_CH")
  fr_CH_new <- fr_CH
  fr_CH_new$target <- ifelse(is.na(fr_CH$target), fr$target, fr_CH$target)
  # TODO if there ever is a discrepancy, add here to save the merged translations as the new swiss file
  results <- rbind(results, c(slug, sum(!compareNA(fr_CH$target, fr_CH_new$target), na.rm = TRUE)))
}
# Check if there was any discrepancy (aka translations that could be brought in from France)
sum(as.numeric(results$X.0.))


# Helper
compareNA <- function(v1,v2) {
  same <- (v1 == v2) | (is.na(v1) & is.na(v2))
  same[is.na(same)] <- FALSE
  return(same)
}
