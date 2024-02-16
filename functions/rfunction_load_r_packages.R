# Declare packages to be loaded in a object names "packages"

# Loop through each package
load_r_packages <- function(packages){
  package.check <- lapply(
    packages,
    FUN = function(x) {
      if (!require(x, character.only = TRUE)) {
        install.packages(x, dependencies = TRUE)
        library(x, character.only = TRUE)
      } 
    }
  )
}#END
