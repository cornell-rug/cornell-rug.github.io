# This is the script from the 2/3 meeting of the cornell R user's group - we went through it together so it's not documented, but shared here in case it's helpful to anyone.

library(patchwork)
library(ggplot2)
library(gtsummary)
library(palmerpenguins)

data("penguins")
penguins

plt1 <- 
  penguins |> 
  ggplot(aes(x = species, y = bill_length_mm)) + geom_boxplot() + labs(title = "Plot 1")
plt1

plt2 <- penguins |> ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) + geom_point() + labs(title = "Plot2")
plt2

plt3 <- penguins |> ggplot(aes(x = island, y = bill_depth_mm)) +
  geom_boxplot() + labs(title = "Plot3")
plt3

plt4 <- penguins |> ggplot(aes(x = flipper_length_mm, y = bill_depth_mm)) + geom_point() + labs(title = "Plot4")
plt4

plt1 + plt2 + plt3

plt1 + (plt2 + plt3)

(plt1 + plt2) + plt3

plt1 + plt2 - plt3

plt1 + plt2 + plt3 + plt4

plt1 + (plt2/plt3)
plt1 / (plt2 + plt3)



plt1 + plt2 + plt3 + plt4 + plot_annotation(title = "All the plots")

plt1 | (plt2 + plot_spacer() + plt3 + plt4)

plt1 | (plt2 / plt3) | plt4

plt1 + plt2 + plt3 + plot_layout(nrow = 2)

plt1 | (plt2 / plt3) | plt4 + plot_annotation(title = "All the plots")

(plt1 | (plt2 / plt3) | plt4) + plot_annotation(title = "All the plots")

plt1 + plt2 + plt3 + plt4 + plot_annotation(tag_levels = "A")

patch <- plt1 | (plt2 / plt3)
patch | plt4

patch + (tbl_summary(penguins) |> as_gt())

plt1 / (plt2 + plt3) & theme_minimal()
plt1 / (plt2 + plt3 * theme_minimal())
plt1 / ((plt2 + plt3) * theme_minimal())

patch
patch + plot_layout(widths = c(1,2))

layout <- "
##BBBB
AACCDD
##CCDD
"
plt1 + plt2 + plt3 + plt4 +
  plot_layout(design = layout)

plt2 <- plt2 + labs(x = "a \n very \n verbose \n axis \n title")
plt2

plt1 + plt2

free(plt1) + plt2
free(plt1) + plt2 + plt3

p1 <- penguins |> ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + geom_point()
p1

p2 <- penguins |> ggplot(aes(x = island, y = bill_length_mm, color = species)) + geom_boxplot()
p2

p1 + p2

p1 + p2 + plot_layout(guides = "collect")

p3 <- penguins |> ggplot(aes(x = bill_length_mm, y = flipper_length_mm, color = species)) + geom_point()
p3

p1 + p3
p1 + p3 + plot_layout(guides = "collect")

p4 <- penguins |> ggplot(aes(x = flipper_length_mm, y = bill_depth_mm, color = species)) + geom_point()
p4

p1
p4
p1 + p4
p1 + p4 + plot_layout(guides = "collect")
p1 + p4 + plot_layout(guides = "collect", axes = "collect")

p1 + p4 + plot_layout(guides = "collect", axis_titles = "collect")

p1 + p2 + p3 + p4 + plot_annotation(
  title = "Title",
  subtitle = "Details",
  caption = "Other stuff"
)

(free(p1) + p2) + p3 + p4 + plot_annotation(
  title = "Title",
  subtitle = "Details",
  caption = "Other stuff",
  tag_levels = "a"
) + 
  plot_layout(guides = "collect", axes = "collect")

