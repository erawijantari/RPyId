#Live coding by: Felix Salim

library(tidyverse)

#load data
surveys <- read_csv('data_raw/portal_data_joined.csv')

#prepare data
surveys_complete <- surveys %>%
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex))


## Extract the most common species_id
species_counts <- surveys_complete %>%
  count(species_id) %>% 
  filter(n >= 50)

## Only keep the most common species
surveys_complete <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()
dev.off()

test_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))
dev.off()


ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_violin(draw_quantiles = 0.5)

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot() +
  scale_y_log10()
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot()
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.1, color = "tomato")
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.1, aes(color = as.factor(plot_id))) +
  geom_boxplot(alpha = 0)

yearly_counts <- surveys_complete %>%
  count(year, genus)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = genus)) +
  geom_line()
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, linetype = genus)) +
  geom_line()
