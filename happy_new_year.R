# load libraries
library(ggplot2) # the best plotting tool ever
library(gganimate) # animation tool for the best plotting tool ever
library(transformr) # gganimate requirement 
library(gifski) # gganimate requirement 
library(png) # gganimate requirement 
library(wesanderson) # fun color palettes

# create data frame of letters
text_df <- data.frame("letter" = c("H",
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
                                   "R"),
                      "x" = c(seq(from = 0.2, to = 0.8, length.out = 8), # x values for HAPPY NEW
                              seq(from = 0.3, to = 0.7, length.out = 4)), # x values for YEAR
                      "y" = c(rep(0.6, 8), # y values for HAPPY NEW
                              rep(0.4, 4)) # y values for YEAR
)




# declare this function from stackoverflow user joran which creates a table of x and y coordinates to draw a circle
# https://stackoverflow.com/questions/6862742/draw-a-circle-with-ggplot2
circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

# call the function to create circle DF which draws a circle around the text
circle_df <- circleFun(center = c(0.5, 0.52), diameter = 0.80, npoints = 50)

# create a column matching the "letter" column in text_df - every row should be empty
circle_df$letter <- rep("", nrow(circle_df))

# bind text and circle DFs together
full_df <- rbind(text_df, circle_df)

# assign every row a value from 1 to 5 to map to one of the 5 colors in the Darjeeling1 Wes Anderson color palette
full_df$color <- rep(seq(from = 1, to = 5), ceiling(nrow(full_df)/5))[1:nrow(full_df)]

# give every row a frame number for the animation to reveal along
full_df$frame_number <- seq(1, nrow(full_df))

# set alpha (image transparency) values for every row - this will set geom_point() and geom_path() to be invisible if the letter column holds the value ""
# this is needed to prevent geom_path() from drawing lines between the letters in the greeting
full_df$circle_alpha_rule <- ifelse(full_df$letter == "", 1, 0)

# create the plot
animation <-
  ggplot(data = full_df, aes(x = x, y = y, color = factor(color))) +
  geom_text(aes(label = letter, group = frame_number), size = 12) + 
  geom_point(aes(alpha = circle_alpha_rule)) +
  geom_path(aes(alpha = circle_alpha_rule)) +
  xlim(0,1) +
  ylim(0,1) +
  scale_color_discrete(wes_palette("Darjeeling1")) +
  scale_alpha(range = c(0, 1)) + # default alpha scale is actually c(0.1, 1), meaning values of 0 were not making geom_path() completely invisible
  theme_void() +
  theme(legend.position = "none") +
  transition_reveal(along = frame_number)

# animate the plot
animate(animation, nframes = 100)

# save a copy of the animation
anim_save("happy_new_year.gif")

# or specify resolution
# anim_save("happy_new_year.gif", animation, width = 1000, height = 1000)
