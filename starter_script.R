# load libraries
library(ggplot2) # the best plotting tool ever
library(gganimate) # animation tool for the best plotting tool ever
library(transformr) # gganimate requirement 
library(gifski) # gganimate requirement 
library(png) # gganimate requirement 

# create data frame of dots. line breaks loosely indicate different sections of the letters or changes in pen stroke when writing the letters
df <- data.frame("greeting" = c("H",
                                "A",
                                "P",
                                "P",
                                "Y",
                                " N",
                                "E",
                                "W")
                 )

# sequential plotting order for points
df$frame_number <- seq(1, nrow(df))

# coordinate locations for text. leaving some empty space on the edges of the frame as padding
df$x <- seq(from = 0.2, to = 0.8, length.out = nrow(df))
df$y <- seq(from = 0.2, to = 0.8, length.out = nrow(df))

animation <-
ggplot(data = df, aes(x = x, y = y)) +
  geom_text(aes(label = greeting, group = frame_number), size = 12) + 
  xlim(0,1) +
  ylim(0,1) +
  transition_reveal(along = frame_number) +
  shadow_mark()

animate(animation)

## TODO: add another class of points with a an alpha of 0.00 to serve as invisible connectors between letters
## ALTERNATE IDEA: just spell out "Happy New Year" in geom_text(), and animate geom_point() stars shooting out of the center like fireworks with geom_line() trails
