## Packages
library(sf)
library(data.table)
library(rgdal)


## Data

## Function
# Project coordinates inside a data.table within converting to a spatial object
# Uses rgdal::project a matrix of geographical positions to projected coordinates
# Expectated order: X coordinate, Y coordinate
project_coords <- function(DT, coords, projection, projcoords) {
  if (!is.data.table(DT)){
    DT <- as.data.table(DT)
  }
  DT[, (projcoords) :=
       data.table::as.data.table(
         rgdal::project(
           as.matrix(.SD, ncol = 2),
           projection)
       ),
     .SDcols = coords][]
  DT <- as.data.frame(DT)
  DT
}


# Useful checks to add:
#   Are the columns named in coords numeric?
#   Is the projection a character?
#   Is it a valid projection?
#   Are the coord1inates in the right order?

## Usage
# Example data from question

# Note: using a data.table instead of a data.frame here
#       so we can use the function below to add new projected columns
# toconv <-
#   data.table(
#     id = c("a", "b", "c"),
#     lat = c(54.530776, 54.551913, 54.455268),
#     lon = c(-2.6006958, -2.4084351, -2.4688599)
#   )
# 
# # Setup output CRS (using the sf function st_crs and returning the WKT representation)
# projection <- st_crs(27700)$wkt
# 
# 
# # Project coordinates
# project_coords(
#   DT = toconv,
#   coords = c('lon', 'lat'),
#   projection = projection,
#   projcoords = c('Xbng', 'Ybng')
# )
# #>    id      lat       lon     Xbng     Ybng
# #> 1:  a 54.53078 -2.600696 361131.2 515235.4
# #> 2:  b 54.55191 -2.408435 373585.3 517497.9
# #> 3:  c 54.45527 -2.468860 369605.8 506769.7
