# load libraries
library(ggplot2) # the best plotting tool ever
library(gganimate) # animation tool for the best plotting tool ever
library(transformr) # gganimate requirement 
library(gifski) # gganimate requirement 
library(png) # gganimate requirement 

# create data frame of dots. line breaks loosely indicate different sections of the letters or changes in pen stroke when writing the letters
df <- data.frame("x" = c(33, 82, 87, 87, 81, # start H
                         95, 131, 165,
                         196, 204, 206, 208,
                         208, 225, 245, # end H
                         257, 283, 307, 330, # start A
                         344, 360, 378,
                         292, 325, 355 # end A
                         ),
                 "y" = c(378, 328, 290, 235, 166, # start H
                         268, 271, 272,
                         255, 231, 194, 162,
                         326, 362, 372, # end H
                         303, 269, 233, 192, # start A
                         231, 265, 304,
                         248, 249, 247 # end A
                         ),
                 "symbol" = c(rep("H", 15),
                              rep("A", 10)))

# sequential plotting order for points
df$point_number <- seq(1, nrow(df))

# calculate values for drawing a smoothed loess line outside of ggplot
# inspiration from https://stackoverflow.com/questions/60856938/animate-points-and-regression-line-along-date-with-gganimate
df$smoothed_y_values <- predict(loess(y ~ x, df))

# sample plot
plot(df)


# ggplot of points with geom_smooth() drawing lines between dots to animate handwriting
ggplot(data = df, aes(x = x, y = y)) +
  geom_point() +
  geom_line() +
  xlim(0,1000) +
  ylim(0,1000) +
  scale_y_reverse()




animation <-
ggplot(data = df, aes(x = x, y = y)) +
  geom_point() +
  geom_line(color = "red") +
  xlim(0,1000) +
  ylim(0,1000) +
  scale_y_reverse() +
  transition_reveal(point_number)

animate(animation)

## TODO: add another class of points with a an alpha of 0.00 to serve as invisible connectors between letters
## ALTERNATE IDEA: just spell out "Happy New Year" in geom_text(), and animate geom_point() stars shooting out of the center like fireworks with geom_line() trails
