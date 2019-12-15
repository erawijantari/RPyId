Answer for challenge in Data is beautiful part 1 - Hello Tidyverse\! : R
Seriesr
================

## Challenge 1

> Using pipes, subset the surveys data to include animals collected
> before 1995 and retain only the columns year, sex, and weight.

``` r
## load the tidyverse packages, incl. dplyr
library("tidyverse")
## ── Attaching packages ────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
## ✓ ggplot2 3.2.1     ✓ purrr   0.3.3
## ✓ tibble  2.1.3     ✓ dplyr   0.8.3
## ✓ tidyr   1.0.0     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.4.0
## ── Conflicts ───────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
#load data as surveys
surveys <- read_csv("data_raw/portal_data_joined.csv")
## Parsed with column specification:
## cols(
##   record_id = col_double(),
##   month = col_double(),
##   day = col_double(),
##   year = col_double(),
##   plot_id = col_double(),
##   species_id = col_character(),
##   sex = col_character(),
##   hindfoot_length = col_double(),
##   weight = col_double(),
##   genus = col_character(),
##   species = col_character(),
##   taxa = col_character(),
##   plot_type = col_character()
## )
```

``` r
surveys_cl1 <- surveys %>%
  filter(year<1995) %>%
  select(year,sex, weight)
glimpse(surveys_cl1)
## Observations: 21,486
## Variables: 3
## $ year   <dbl> 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1978, 1978, 197…
## $ sex    <chr> "M", "M", NA, NA, NA, NA, NA, NA, "M", NA, NA, "M", "M", …
## $ weight <dbl> NA, NA, NA, NA, NA, NA, NA, NA, 218, NA, NA, 204, 200, 19…
```

Notice that we can sellect multiple columns. `,` is for **and** and `|`
is for **or**. Remeber we can use `glimpse()` to see the overview of
data.

## Challenge 2

> Create a new data frame from the surveys data that meets the following
> criteria: contains only the species\_id column and a new column called
> hindfoot\_half containing values that are half the hindfoot\_length
> values. In this hindfoot\_half column, there are no NAs and all values
> are less than 30. Hint: think about how the commands should be ordered
> to produce this data frame\!

``` r
surveys_cl2 <- surveys %>%
    filter(!is.na(hindfoot_length)) %>%
    mutate(hindfoot_half = hindfoot_length / 2) %>%
    filter(hindfoot_half < 30) %>%
    select(species_id, hindfoot_half)
glimpse(surveys_cl2)
## Observations: 31,436
## Variables: 2
## $ species_id    <chr> "NL", "NL", "NL", "NL", "NL", "NL", "NL", "NL", "N…
## $ hindfoot_half <dbl> 16.0, 15.5, 16.0, 17.0, 16.0, 16.5, 16.0, 16.0, 16…
```

## Challenge 3

> 1.  How many animals were caught in plot\_type surveyed?

``` r
surveys %>%
    count(plot_type) 
```

    ## # A tibble: 5 x 2
    ##   plot_type                     n
    ##   <chr>                     <int>
    ## 1 Control                   15611
    ## 2 Long-term Krat Exclosure   5118
    ## 3 Rodent Exclosure           4233
    ## 4 Short-term Krat Exclosure  5906
    ## 5 Spectab exclosure          3918

> 2.  Use group\_by() and summarize() to find the mean, min, and max
>     hindfoot length for each species (using species\_id). Also add the
>     number of observations (hint: see ?n).

``` r
surveys %>%
    filter(!is.na(hindfoot_length)) %>%
    group_by(species_id) %>%
    summarize(
        mean_hindfoot_length = mean(hindfoot_length),
        min_hindfoot_length = min(hindfoot_length),
        max_hindfoot_length = max(hindfoot_length),
        n = n()
    )
```

    ## # A tibble: 25 x 5
    ##    species_id mean_hindfoot_len… min_hindfoot_leng… max_hindfoot_len…     n
    ##    <chr>                   <dbl>              <dbl>             <dbl> <int>
    ##  1 AH                       33                   31                35     2
    ##  2 BA                       13                    6                16    45
    ##  3 DM                       36.0                 16                50  9972
    ##  4 DO                       35.6                 26                64  2887
    ##  5 DS                       49.9                 39                58  2132
    ##  6 NL                       32.3                 21                70  1074
    ##  7 OL                       20.5                 12                39   920
    ##  8 OT                       20.3                 13                50  2139
    ##  9 OX                       19.1                 13                21     8
    ## 10 PB                       26.1                  2                47  2864
    ## # … with 15 more rows

> 3.  What was the heaviest animal measured in each year? Return the
>     columns year, genus, species\_id, and weight.

``` r
surveys %>%
    filter(!is.na(weight)) %>%
    group_by(year) %>%
    filter(weight == max(weight)) %>%
    select(year, genus, species, weight) %>%
    arrange(year)
```

    ## # A tibble: 27 x 4
    ## # Groups:   year [26]
    ##     year genus     species     weight
    ##    <dbl> <chr>     <chr>        <dbl>
    ##  1  1977 Dipodomys spectabilis    149
    ##  2  1978 Neotoma   albigula       232
    ##  3  1978 Neotoma   albigula       232
    ##  4  1979 Neotoma   albigula       274
    ##  5  1980 Neotoma   albigula       243
    ##  6  1981 Neotoma   albigula       264
    ##  7  1982 Neotoma   albigula       252
    ##  8  1983 Neotoma   albigula       256
    ##  9  1984 Neotoma   albigula       259
    ## 10  1985 Neotoma   albigula       225
    ## # … with 17 more rows

## Challenge 4

> 1.  Spread (convert the long format to wide format) the surveys data
>     frame with year as columns, plot\_id as rows, and the number of
>     genera per plot as the values. You will need to summarize before
>     reshaping, and use the function n\_distinct() to get the number of
>     unique genera within a particular chunk of data. It’s a powerful
>     function\! See ?n\_distinct for more.

Using `plot_wider()`

``` r
distinct_genera <- surveys %>%
  group_by(plot_id, year) %>%
  summarize(n_genera = n_distinct(genus)) %>%
  pivot_wider(names_from= year, values_from= n_genera)

head(distinct_genera)
## # A tibble: 6 x 27
## # Groups:   plot_id [6]
##   plot_id `1977` `1978` `1979` `1980` `1981` `1982` `1983` `1984` `1985`
##     <dbl>  <int>  <int>  <int>  <int>  <int>  <int>  <int>  <int>  <int>
## 1       1      2      3      4      7      5      6      7      6      4
## 2       2      6      6      6      8      5      9      9      9      6
## 3       3      5      6      4      6      6      8     10     11      7
## 4       4      4      4      3      4      5      4      6      3      4
## 5       5      4      3      2      5      4      6      7      7      3
## 6       6      3      4      3      4      5      9      9      7      5
## # … with 17 more variables: `1986` <int>, `1987` <int>, `1988` <int>,
## #   `1989` <int>, `1990` <int>, `1991` <int>, `1992` <int>, `1993` <int>,
## #   `1994` <int>, `1995` <int>, `1996` <int>, `1997` <int>, `1998` <int>,
## #   `1999` <int>, `2000` <int>, `2001` <int>, `2002` <int>
```

Using `spread()`

``` r
rich_time <- surveys %>%
  group_by(plot_id, year) %>%
  summarize(n_genera = n_distinct(genus)) %>%
  spread(year, n_genera)

head(rich_time)
## # A tibble: 6 x 27
## # Groups:   plot_id [6]
##   plot_id `1977` `1978` `1979` `1980` `1981` `1982` `1983` `1984` `1985`
##     <dbl>  <int>  <int>  <int>  <int>  <int>  <int>  <int>  <int>  <int>
## 1       1      2      3      4      7      5      6      7      6      4
## 2       2      6      6      6      8      5      9      9      9      6
## 3       3      5      6      4      6      6      8     10     11      7
## 4       4      4      4      3      4      5      4      6      3      4
## 5       5      4      3      2      5      4      6      7      7      3
## 6       6      3      4      3      4      5      9      9      7      5
## # … with 17 more variables: `1986` <int>, `1987` <int>, `1988` <int>,
## #   `1989` <int>, `1990` <int>, `1991` <int>, `1992` <int>, `1993` <int>,
## #   `1994` <int>, `1995` <int>, `1996` <int>, `1997` <int>, `1998` <int>,
## #   `1999` <int>, `2000` <int>, `2001` <int>, `2002` <int>
```

> 2.  Now take that data frame and gather (reshaped it into long format)
>     again, so each row is a unique plot\_id by year combination.

Using `plot_longer()`

``` r
returned <- distinct_genera %>% 
  pivot_longer(names_to = "year", values_to = "n_genera", -plot_id)
  
glimpse(returned)
## Observations: 624
## Variables: 3
## Groups: plot_id [24]
## $ plot_id  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
## $ year     <chr> "1977", "1978", "1979", "1980", "1981", "1982", "1983",…
## $ n_genera <int> 2, 3, 4, 7, 5, 6, 7, 6, 4, 3, 7, 6, 8, 7, 7, 5, 5, 6, 5…
```

Using `gather()`

``` r
returned_gather <- rich_time %>%
  gather(year, n_genera, -plot_id)
glimpse(returned_gather)
## Observations: 624
## Variables: 3
## Groups: plot_id [24]
## $ plot_id  <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, …
## $ year     <chr> "1977", "1977", "1977", "1977", "1977", "1977", "1977",…
## $ n_genera <int> 2, 6, 5, 4, 4, 3, 3, 2, 3, 1, 5, 5, 3, 3, 2, 3, 4, 2, 4…
```

> 3.  The surveys data set has two measurement columns: hindfoot\_length
>     and weight. This makes it difficult to do things like look at the
>     relationship between mean values of each measurement per year in
>     different plot types. Let’s walk through a common solution for
>     this type of problem. First, use `gather()` or `pivot_longer()` to
>     create a dataset where we have a key column called measurement and
>     a value column that takes on the value of either hindfoot\_length
>     or weight. Hint: You’ll need to specify which columns are being
>     gathered.

use `gather()`

``` r
surveys_long <- surveys %>%
  gather(measurement, value, hindfoot_length, weight)
glimpse(surveys_long)
```

    ## Observations: 69,572
    ## Variables: 13
    ## $ record_id   <dbl> 1, 72, 224, 266, 349, 363, 435, 506, 588, 661, 748, …
    ## $ month       <dbl> 7, 8, 9, 10, 11, 11, 12, 1, 2, 3, 4, 5, 6, 8, 9, 10,…
    ## $ day         <dbl> 16, 19, 13, 16, 12, 12, 10, 8, 18, 11, 8, 6, 9, 5, 4…
    ## $ year        <dbl> 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1978, 1978…
    ## $ plot_id     <dbl> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2…
    ## $ species_id  <chr> "NL", "NL", "NL", "NL", "NL", "NL", "NL", "NL", "NL"…
    ## $ sex         <chr> "M", "M", NA, NA, NA, NA, NA, NA, "M", NA, NA, "M", …
    ## $ genus       <chr> "Neotoma", "Neotoma", "Neotoma", "Neotoma", "Neotoma…
    ## $ species     <chr> "albigula", "albigula", "albigula", "albigula", "alb…
    ## $ taxa        <chr> "Rodent", "Rodent", "Rodent", "Rodent", "Rodent", "R…
    ## $ plot_type   <chr> "Control", "Control", "Control", "Control", "Control…
    ## $ measurement <chr> "hindfoot_length", "hindfoot_length", "hindfoot_leng…
    ## $ value       <dbl> 32, 31, NA, NA, NA, NA, NA, NA, NA, NA, NA, 32, NA, …

> 4.  With this new data set, calculate the average of each measurement
>     in each year for each different plot\_type. Then spread() them
>     into a data set with a column for hindfoot\_length and weight.
>     Hint: You only need to specify the key and value columns for
>     `spread()` or `pivot_wider()`.

use `spread()`

``` r
surveys_long %>%
  group_by(year, measurement, plot_type) %>%
  summarize(mean_value = mean(value, na.rm=TRUE)) %>%
  spread(measurement, mean_value)
```

    ## # A tibble: 130 x 4
    ## # Groups:   year [26]
    ##     year plot_type                 hindfoot_length weight
    ##    <dbl> <chr>                               <dbl>  <dbl>
    ##  1  1977 Control                              36.1   50.4
    ##  2  1977 Long-term Krat Exclosure             33.7   34.8
    ##  3  1977 Rodent Exclosure                     39.1   48.2
    ##  4  1977 Short-term Krat Exclosure            35.8   41.3
    ##  5  1977 Spectab exclosure                    37.2   47.1
    ##  6  1978 Control                              38.1   70.8
    ##  7  1978 Long-term Krat Exclosure             22.6   35.9
    ##  8  1978 Rodent Exclosure                     37.8   67.3
    ##  9  1978 Short-term Krat Exclosure            36.9   63.8
    ## 10  1978 Spectab exclosure                    42.3   80.1
    ## # … with 120 more rows
