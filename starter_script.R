# load libraries
library(ggplot2) # the best plotting tool ever
library(gganimate) # animation tool for the best plotting tool ever

# create data frame of dots. line breaks loosely indicate different sections of the letters or changes in pen stroke when writing the letters
df <- data.frame("x" = c(33, 82, 87, 87, 81,
                         95, 131, 165,
                         196, 204, 206, 208,
                         208, 225, 245 
                         ),
                 "y" = c(378, 328, 290, 235, 166,
                         268, 271, 272,
                         255, 231, 194, 162,
                         326, 362, 372),
                 "symbol" = c(rep("H", 15)))

# sample plot
plot(df)


# ggplot of points with geom_smooth() drawing lines between dots to animate handwriting
ggplot(data = df, aes(x = x, y = y)) +
  geom_point() +
  xlim(0,1000) +
  ylim(0,1000) +
  scale_y_discrete(limits = "rev")

+
  scale() # TODO set scale to start at 0 and end at 1000 for both x and y