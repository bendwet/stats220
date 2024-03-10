library(magick)

# image 1
average_hater <- image_read("images/hater.png") %>%
  image_scale(500)

# image 1 text
hater_text <- image_blank(width = 500, 
                          height = 50, 
                          color = "#FFFFFF",) %>%
  image_annotate(text = "Typical Stats 220 Hater",
                 color = "#000000",
                 size = 40,
                 font = "Arial",
                 gravity = "center") %>%
  image_charcoal()


# image 2
average_enjoyer <- image_read("images/chad.jpg") %>%
  image_scale(500)

# image 2 text
enjoyer_text <- image_blank(width = 500, 
                            height = 50, 
                            color = "#FFFFFF") %>%
  image_annotate(text = "Average Stats 220 Enjoyer",
                 color = "#000000",
                 size = 40,
                 font = "Arial",
                 gravity = "center") %>%
  image_charcoal()

# black bar
text_black_bar <- image_blank(width = 3,
                         height = 50,
                         color = "#000000")
image_black_bar <- image_blank(width = 3,
                              height = 500,
                              color = "#000000")

# make the columns

# text row
text_vector <- c(hater_text, text_black_bar, enjoyer_text)
top_row <- image_append(text_vector)

# images row
image_vector <- c(average_hater, image_black_bar, average_enjoyer)
bottom_row <- image_append(image_vector)

meme <- c(top_row, bottom_row) %>%
  image_append(stack = TRUE)

image_write(meme, "my_meme.png")

# Gif part

# numbers for the color squares text
counts <- 1: 3 %>% as.character()

green_square <- image_blank(color = 'green', width = 400, height = 400)
orange_square <- image_blank(color = 'orange', width = 300, height = 300)
red_square <- image_blank(color = 'red', width = 200, height = 200)

frame1 <- red_square %>%
  image_annotate(text = counts[3], size = 100, gravity = "center") %>%
  image_scale(200) %>%
  image_extent("500x500")

frame2 <- orange_square %>%
  image_annotate(text = counts[2], size = 100, gravity = "center") %>%
  image_scale(300) %>%
  image_extent("500x500")

frame3 <- green_square %>%
  image_annotate(text = counts[1], size = 100, gravity = "center") %>%
  image_scale(400) %>%
  image_extent("500x500")

frame4 <- meme %>%
  image_scale(500) %>%
  image_extent("500x500")

# frames vector
frames <- c(frame1, frame2, frame3)
morph_frames <- image_morph(c(frame3, frame4), frames=5)

all_frames = c(frames, morph_frames)


# create animation
animation <- image_animate(all_frames, fps = 2)

animation

image_write(animation, "my_animation.gif")