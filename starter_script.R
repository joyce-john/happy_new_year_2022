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

plot(seq(0.5, 1, 0.01)^5 + 0.5, (seq(0.5, 1, 0.01))) # prototype sequence for streaming star path

df2 <- data.frame("x" = c((seq(0.5, 1, 0.03)^5 + 0.5),
                          (seq(0.5, -1, -0.03)^5 + 0.6)),
                  "y" = c(seq(0.5, 1, 0.03),
                          seq(0.5, 1, 0.03)),
                  "star_group" = c(rep(1,17),
                                   rep(2,17)))

df2$frame_number <- seq(1, nrow(df2))

animation2 <-
ggplot(df2, aes(x = x, y = y, group = factor(star_group))) +  
  geom_path() +
  geom_point() +
  transition_reveal(along = frame_number)

animate(animation2, nframes = 20)


# circle function from stackoverflow user joran
# https://stackoverflow.com/questions/6862742/draw-a-circle-with-ggplot2
circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

df3 <-
circleFun(center = c(0.5, 0.5), diameter = 0.75, npoints = 50)

df3$greeting <- rep("", nrow(df3))
df3$frame_number <- seq(from = nrow(df) + 1, to = (nrow(df) + nrow(df3)), by = 1)
df3$text_color <- rep(1, nrow(df3))

df4 <-
  rbind(df, df3)

df4$point_alpha <- ifelse(df4$greeting == "", 1, 0)

animation3 <-
  ggplot(data = df4, aes(x = x, y = y)) +
  geom_text(aes(label = greeting, group = frame_number, color = factor(text_color)), size = 12) + 
  geom_point(aes(alpha = point_alpha)) +
  geom_path(aes(alpha = point_alpha)) +
  xlim(0,1) +
  ylim(0,1) +
  scale_color_discrete(wes_palette("Darjeeling1")) +
  # theme_void() #uncomment when done with other steps
  theme(legend.position = "none") +
  transition_reveal(along = frame_number)

animate(animation3, nframes = 20)
