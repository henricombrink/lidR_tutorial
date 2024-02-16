# windows size that adapts to the height of pixels or height of the points
# windows size is related to the point height with an affine relationship
# When a point is at 0 the windows size is 3 meters. At 10 m it is 4 m and so on

lmf_varw_1 <- function(x) {x * 0.1 + 3}