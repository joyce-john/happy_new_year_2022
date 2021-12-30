# load libraries
library(ggplot2) # the best plotting tool ever
library(gganimate) # animation tool for the best plotting tool ever
library(transformr) # gganimate requirement 
library(gifski) # gganimate requirement 
library(png) # gganimate requirement 
library(wesanderson) # fun color palettes

# create data frame of dots. line breaks loosely indicate different sections of the letters or changes in pen stroke when writing the letters
df <- data.frame("greeting" = c("H",
                                "A",
                                "P",
                                "P",
                                "Y ",
                                "N",
                                "E",
                                "W",
                                "Y",
                                "E",
                                "A",
                                "R")
                 )

# sequential plotting order for points
df$frame_number <- seq(1, nrow(df))

# coordinate locations for text. leaving some empty space on the edges of the frame as padding
df$x <- c(seq(from = 0.2, to = 0.8, length.out = 8), # x axis for HAPPY NEW
          seq(from = 0.3, to = 0.7, length.out = 4)) # x axis for YEAR
                    
df$y <- c(rep(0.6, 8), # y axis for HAPPY NEW
          rep(0.4, 4)) # y axis for YEAR

# assign a value from 1 to 5 to map to one of the colors in the Darjeeling1 Wes Anderson color palette
df$text_color <- rep(seq(from = 1, to = 5), ceiling(nrow(df)/5))[1:nrow(df)]

animation <-
ggplot(data = df, aes(x = x, y = y)) +
  geom_text(aes(label = greeting, group = frame_number, color = factor(text_color)), size = 12) + 
  xlim(0,1) +
  ylim(0,1) +
  scale_color_discrete(wes_palette("Darjeeling1")) +
  # theme_void() #uncomment when done with other steps
  theme(legend.position = "none") +
  transition_reveal(along = frame_number)

animate(animation, nframes = 20)

## TODO: animate geom_point() stars shooting out of the center like fireworks with geom_line() or geom_path() trails
## stars can be mapped with random colors from the palette
