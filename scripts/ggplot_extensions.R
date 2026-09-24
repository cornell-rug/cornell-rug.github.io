# These are notes from the Sept 23rd meeting of the Cornell R User's group (with virtually no comments since these were for demoing)
# Matt Thomas



# ggplot extensions

library(ggplot2)
library(palmerpenguins)

penguins

penguins |>
  ggplot(aes(x = bill_length_mm, y = flipper_length_mm)) +
  geom_point()





#library(patchwork)
#library(gganimate)

library(esquisse)
esquisser(palmerpenguins::penguins)

penguins |>
  ggplot(aes(x = bill_length_mm, flipper_length_mm, color = island)) +
  geom_point() +
  geom_text(
    data = data.frame(x = 38.64, y = 226.21, label = "cool stuff"),
    mapping = aes(x = x, y = y, label = label),
    size = 3.88,
    colour = "#000000",
    inherit.aes = FALSE
  )

library(ggannotate)
ggannotate()

library(ggrepel)
penguins$id <- rownames(penguins)

penguins |>
  ggplot(aes(x = bill_length_mm, flipper_length_mm)) +
  geom_point() +
  geom_label(aes(label = id))

penguins |>
  ggplot(aes(x = bill_length_mm, flipper_length_mm)) +
  geom_point() +
  geom_label_repel(aes(label = id))

library(ggh4x)

penguins |>
  ggplot(aes(bill_length_mm, bill_depth_mm)) +
  geom_point(alpha = 0.7) +
  facet_nested(~ species + island)
# vs facet_grid(~ species + island) and facet_wrap(~ species + island)

penguins |>
  ggplot(aes(bill_length_mm, body_mass_g)) +
  geom_point(alpha = 0.7) +
  facet_grid2(
    sex ~ species,
    #vars(species),
    scales = "free",
    independent = "all"
  )

#facet_grid(sex ~ species, scales = "free")
# vs facet_grid(scales = "free"), bad example because of patchwork

penguins |>
  ggplot(aes(body_mass_g)) +
  geom_histogram(
    aes(y = after_stat(density)),
    bins = 20,
    fill = "grey80",
    colour = "white"
  ) +
  stat_theodensity(distri = "norm", colour = "firebrick") +
  stat_theodensity(distri = "gamma", colour = "steelblue") +
  facet_wrap(~ species)

library(ggreveal)
p <-  ggplot(penguins[!is.na(penguins$sex), ],
             aes(
               body_mass_g,
               bill_length_mm,
               group = sex,
               color = sex
             )) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~ species) +
  theme_minimal()
p

p |> reveal_aes()
p |> reveal_groups()
p |> reveal_layers()
p <- p |> reveal_panels()

p <-  ggplot(penguins[!is.na(penguins$sex), ], aes(x = island, y = bill_length_mm)) +
  geom_boxplot() +
  facet_wrap(~ species) +
  theme_minimal()
p

p |> reveal_x()

library(ggpointdensity)
penguins |>
  ggplot(aes(x = bill_length_mm, y = flipper_length_mm)) +
  #geom_point()
  geom_pointdensity() +
  scale_color_viridis_b()

diamonds |>
  ggplot(aes(x = carat, y = depth)) +
  geom_pointdensity() +
  scale_color_viridis_b()

library(ggrain)
penguins |>
  ggplot(aes(x = island, y = flipper_length_mm, fill = island)) +
  geom_rain()
#geom_rain(rain.side = 'l')

penguins |>
  ggplot(aes(
    x = 1,
    y = flipper_length_mm,
    fill = island,
    color = island
  )) +
  geom_rain(alpha = 0.4)

library(ggstats)
# gglikert
mod1 <- penguins |> lm(data = _,
                       flipper_length_mm ~ bill_length_mm + bill_depth_mm + species)
summary(mod1)

ggcoef_model(mod1)
ggcoef_table(mod1)
# can also have multiple models

library(modelbased) # was library(ggeffects)
mod2 <- penguins |> lm(data = _,
                       flipper_length_mm ~ bill_length_mm * bill_depth_mm * species * island)
# this is a funny one
estimate_means(mod2, by = "species") |> plot()
estimate_means(mod2, by = c("species", "island")) |> plot()

library(ggpubr)
# one approach is ggboxplot or gghistogram
penguins |> gghistogram(
  x = "bill_length_mm",
  rug = TRUE,
  color = "sex",
  fill = "sex",
  add = "mean"
)


penguins |>
  ggplot(aes(x = island, y = bill_depth_mm)) +
  geom_boxplot() +
  stat_compare_means()

my_comparisons <- list(c("Biscoe", "Dream"),
                       c("Dream", "Torgersen"),
                       c("Biscoe", "Torgersen"))

penguins |>
  ggplot(aes(x = island, y = bill_depth_mm)) +
  geom_boxplot() +
  stat_compare_means(comparisons = my_comparisons) +
  stat_compare_means(label.y = 27)

penguins |>
  ggplot(aes(x = island, y = bill_depth_mm)) +
  geom_boxplot() +
  geom_pwc(method = "tukey_hsd")


#library(qqplotr)

library(tidyplots)
penguins |>
  tidyplot(y = bill_length_mm, x = species) |>
  add_data_points()

penguins |>
  tidyplot(y = bill_length_mm, x = species) |>
  add_data_points_jitter()

penguins |>
  tidyplot(y = bill_length_mm, x = species) |>
  add_data_points_beeswarm()

p <- penguins |>
  tidyplot(x = species, y = bill_length_mm, color = species) |>
  add_mean_dot() |>
  add_sem_errorbar() |>
  add_title("title") |>
  add_data_points_beeswarm(alpha = 0.3) |>
  remove_legend() |>
  adjust_x_axis_title("speecies") |>
  adjust_colors(colors_discrete_seaside) |>
  split_plot(sex)

# |> save_plot()

# Free it — this restores standard ggplot2 behavior
p |> adjust_size(width = NA, height = NA)

# Set an explicit size
p |> adjust_size(width = 80, height = 60)          # mm by default
p |> adjust_size(width = 4,
                 height = 3,
                 unit = "cm")

# Session-wide, added in 0.3.1
tidyplots_options(width = NA, height = NA)

str(p)
class(p)

p |> adjust_font(fontsize = 20)
