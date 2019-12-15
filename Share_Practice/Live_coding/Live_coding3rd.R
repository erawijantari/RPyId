library(tidyverse)

surveys <- readr::read_csv("Notes/20191215_RPyID3rd/data_raw/portal_data_joined.csv")

select(surveys, -contains("id"))

filter(surveys, year == 1995, species_id == "NL")

surveys_sml <- surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)


surveys %>%
  filter(year < 1995) %>%
  select(year, sex, weight)


surveys %>% 
  mutate(weight_kg = weight / 1000) %>%
  glimpse()

surveys %>% 
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>%
  glimpse()


surveys %>%
  mutate(hindfoot_half = hindfoot_length / 2) %>%
  filter(!is.na(hindfoot_half), hindfoot_half < 30) %>%
  select(species_id, hindfoot_half)

colSums(is.na(surveys))


surveys %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm=TRUE))

surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight),
            min_weight = min(weight),
            max_weight = max(weight)) %>% 
  arrange(desc(max_weight))


surveys %>% 
  count(sex, species_id, sort=TRUE)


surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

surveys_wider %>%
  pivot_longer(cols = -plot_id, names_to = "genus", values_to = "mean_weight") %>%
  pivot_wider(names_from = plot_id, values_from = mean_weight)
