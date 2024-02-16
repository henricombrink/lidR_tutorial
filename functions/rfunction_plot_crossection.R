plot_crossection <- function(las,
                             p1 = c(min(las@data$X), mean(las@data$Y)),
                             p2 = c(max(las@data$X), mean(las@data$Y)),
                             width = 4,
                             colour_by = NULL,
                             Xt = TRUE,
                             Clip_Transect = TRUE)
{
  colour_by <- rlang::enquo(colour_by)
  
  if (isTRUE(Clip_Transect)){
    data_clip <- clip_transect(las, p1, p2, width)
  } else {
    data_clip <- las
  }
  
  if (isTRUE(Xt)){
  p <- ggplot(data_clip@data, aes(X,Z)) + geom_point(size = 0.5) + coord_equal() + theme_minimal()
  } else {
  p <- ggplot(data_clip@data, aes(Y,Z)) + geom_point(size = 0.5) + coord_equal() + theme_minimal()
  }
  
  if (!is.null(colour_by))
    p <- p + aes(color = !!colour_by) + labs(color = "Height (m)") +
      scale_colour_gradient2(low = "green",
                            mid = "yellow",
                            high = "red",
                            midpoint = 15,
                            space = "Lab",
                            na.value = "grey50",
                            guide = "colourbar",
                            aesthetics = "colour")
  
  return(p)
}