Data is beautiful part 1 - Hello Tidyverse\! : R Series
================

**3rdMeeting - Sunday, December 15, 2019**

**Tutors and Organizers:**

  - Pande Putu Erawijantari
  - Felix Salim
  - Mia Fitria Utami

## Content:

  - Introductions about R packages and libraries
  - Data Wrangling session

Sources:

  - Introduction of R packages and
        libraries
      - <https://r4ds.had.co.nz/explore-intro.html>
      - <https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages>
  - Data Wrangling session:
      - <https://datacarpentry.org/R-ecology-lesson/03-dplyr.html>
  - Data:

source: <https://ndownloader.figshare.com/files/2292169>

Execute the command below if you miss the previous meeting.

    dir.create("data_raw")
    
    download.file(url="https://ndownloader.figshare.com/files/2292169",
                  destfile = "data_raw/portal_data_joined.csv")

### Introductions about R packages and libraries

In the previous meeting we have learned how to analyse multiple datasets
using a functions. However, sometimes we need to analyse complex data
which may require complex functions. Don’t worry, many useful R function
come in packages or libraries. In R **packages** are collection of R
functions, data, and compiled code written by R’s active user community
in a well-defined format. The directory where packagase are stored is
call **library**.

To install an R package, you can open an R session in your R studio and
type at the command line

`install.packages("<the package's name>")`

R will download the package from [CRAN](https://cran.r-project.org/), so
you will need to be connected to the internet. It should be noted that
the package instalation only needed if you haven’t done it yet, usually
when you use a package for the first time. To use the installed-package,
you have to call it beforehand. You can make its contents available to
use in your current R session by running the command below (You may
found it is litle bit counter intuitive to call the packages by
`library()` command).

`library("<the package's name>")`

You can see the quick list of useful R packages
[here](https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages).
For our **Data is beautiful: R series**, we will several packages named
[dplyr](https://blog.rstudio.com/2014/01/17/introducing-dplyr/),
[tidyr](http://blog.rstudio.org/2014/07/22/introducing-tidyr/), and
[ggplot2](https://ggplot2.tidyverse.org/reference/) to name of few.
There are also package that contains collections of several packages, so
you don’t need to install it one by one.

[**Tidyvere**](https://www.tidyverse.org/) is one of the example, which
contains a collection of R packages designed for data science. All
package share similar design, grammar, and data structure so that you
can use it all together without worying about the data structure. All of
the package we need for our next session is available in **Tidyverse**,
so let’s install it\!

`install.packages("tidyverse")`

### Data Wrangling Session

**TIPS**: If you want to learn how to type the code properly, remember
the structure for long run, and become sensitive of the typo error or
understanding error message, **DO NOT copy paste the example**. But if
you already know how it works, than it’s ok to copy paste, as you are
not supposed to remember every exact syntax. Copy paste at your own
risk\!

ref: <https://datacarpentry.org/R-ecology-lesson/03-dplyr.html> We have
start looking at the data in the previous meeting but we haven’t analyze
it yet. Let’s get your hand ready\!

#### Data manipulation using **dyplyr** and **tidyr**

Previously, we learn to parse our data using bracket, but it can be
difficult to read especially if you start using complicated operations.
We will use **dyplyr** and **tidyr** to help us through. **dplyr** is a
package for making tabular data manipulation easier. It pairs nicely
with **tidyr** which enables us to swiftly convert between different
data formats for plotting and analysis. To learn more about **dyplyr**
and **tidyr**, you may want to check out [dyplyr
cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf)
and [tidyr
cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-import.pdf).

As mentioned before, it all installed together during the **tidyverse**
installation. Let’s load the package

``` r
## load the tidyverse packages, incl. dplyr
library("tidyverse")
```

    ## ── Attaching packages ─────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.2.1     ✓ purrr   0.3.3
    ## ✓ tibble  2.1.3     ✓ dplyr   0.8.3
    ## ✓ tidyr   1.0.0     ✓ stringr 1.4.0
    ## ✓ readr   1.3.1     ✓ forcats 0.4.0

    ## ── Conflicts ────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

We’ll read in our data using the `read_csv()` function, from the
tidyverse package readr, instead of `read.csv()` (notice the
underscore(\_) vs point(.)?).

``` r
surveys <- read_csv("data_raw/portal_data_joined.csv")
```

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

``` r
## inspect the data
str(surveys)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 34786 obs. of  13 variables:
    ##  $ record_id      : num  1 72 224 266 349 363 435 506 588 661 ...
    ##  $ month          : num  7 8 9 10 11 11 12 1 2 3 ...
    ##  $ day            : num  16 19 13 16 12 12 10 8 18 11 ...
    ##  $ year           : num  1977 1977 1977 1977 1977 ...
    ##  $ plot_id        : num  2 2 2 2 2 2 2 2 2 2 ...
    ##  $ species_id     : chr  "NL" "NL" "NL" "NL" ...
    ##  $ sex            : chr  "M" "M" NA NA ...
    ##  $ hindfoot_length: num  32 31 NA NA NA NA NA NA NA NA ...
    ##  $ weight         : num  NA NA NA NA NA NA NA NA 218 NA ...
    ##  $ genus          : chr  "Neotoma" "Neotoma" "Neotoma" "Neotoma" ...
    ##  $ species        : chr  "albigula" "albigula" "albigula" "albigula" ...
    ##  $ taxa           : chr  "Rodent" "Rodent" "Rodent" "Rodent" ...
    ##  $ plot_type      : chr  "Control" "Control" "Control" "Control" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   record_id = col_double(),
    ##   ..   month = col_double(),
    ##   ..   day = col_double(),
    ##   ..   year = col_double(),
    ##   ..   plot_id = col_double(),
    ##   ..   species_id = col_character(),
    ##   ..   sex = col_character(),
    ##   ..   hindfoot_length = col_double(),
    ##   ..   weight = col_double(),
    ##   ..   genus = col_character(),
    ##   ..   species = col_character(),
    ##   ..   taxa = col_character(),
    ##   ..   plot_type = col_character()
    ##   .. )

    ## preview the data
    View(surveys)

Notice that the class of the data is now `tbl_df`

This is referred to as a “tibble”. Tibbles tweak some of the behaviors
of the data frame objects we introduced in the previous episode. The
data structure is very similar to a data frame. For our purposes the
only differences are that:

1.  In addition to displaying the data type of each column under its
    name, it only prints the first few rows of data and only as many
    columns as fit on one screen.
2.  Columns of class character are never converted into factors.

We’re going to learn some of the most common dplyr functions:

  - `select()`: subset columns
  - `filter()`: subset rows on conditions
  - `mutate()`: create new columns by using information from other
    columns
  - `group_by()`: and summarize(): create summary statisitcs on grouped
    data
  - `arrange()` : sort results
  - `count()`: count discrete values

#### Selecting column and filtering rows

To select columns of a data frame, use select(). The first argument to
this function is the data frame (surveys), and the subsequent arguments
are the columns to keep.

``` r
select(surveys, plot_id, species_id, weight)
```

    ## # A tibble: 34,786 x 3
    ##    plot_id species_id weight
    ##      <dbl> <chr>       <dbl>
    ##  1       2 NL             NA
    ##  2       2 NL             NA
    ##  3       2 NL             NA
    ##  4       2 NL             NA
    ##  5       2 NL             NA
    ##  6       2 NL             NA
    ##  7       2 NL             NA
    ##  8       2 NL             NA
    ##  9       2 NL            218
    ## 10       2 NL             NA
    ## # … with 34,776 more rows

To select all columns except certain ones, put a “-” in front of the
variable to exclude it.

``` r
select(surveys, -record_id, -species_id)
```

    ## # A tibble: 34,786 x 11
    ##    month   day  year plot_id sex   hindfoot_length weight genus species
    ##    <dbl> <dbl> <dbl>   <dbl> <chr>           <dbl>  <dbl> <chr> <chr>  
    ##  1     7    16  1977       2 M                  32     NA Neot… albigu…
    ##  2     8    19  1977       2 M                  31     NA Neot… albigu…
    ##  3     9    13  1977       2 <NA>               NA     NA Neot… albigu…
    ##  4    10    16  1977       2 <NA>               NA     NA Neot… albigu…
    ##  5    11    12  1977       2 <NA>               NA     NA Neot… albigu…
    ##  6    11    12  1977       2 <NA>               NA     NA Neot… albigu…
    ##  7    12    10  1977       2 <NA>               NA     NA Neot… albigu…
    ##  8     1     8  1978       2 <NA>               NA     NA Neot… albigu…
    ##  9     2    18  1978       2 M                  NA    218 Neot… albigu…
    ## 10     3    11  1978       2 <NA>               NA     NA Neot… albigu…
    ## # … with 34,776 more rows, and 2 more variables: taxa <chr>,
    ## #   plot_type <chr>

This will select all the variables in surveys except record\_id and
species\_id.

To choose rows based on a specific criteria, use filter():

``` r
filter(surveys, year == 1995)
## # A tibble: 1,180 x 13
##    record_id month   day  year plot_id species_id sex   hindfoot_length
##        <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>      <chr>           <dbl>
##  1     22314     6     7  1995       2 NL         M                  34
##  2     22728     9    23  1995       2 NL         F                  32
##  3     22899    10    28  1995       2 NL         F                  32
##  4     23032    12     2  1995       2 NL         F                  33
##  5     22003     1    11  1995       2 DM         M                  37
##  6     22042     2     4  1995       2 DM         F                  36
##  7     22044     2     4  1995       2 DM         M                  37
##  8     22105     3     4  1995       2 DM         F                  37
##  9     22109     3     4  1995       2 DM         M                  37
## 10     22168     4     1  1995       2 DM         M                  36
## # … with 1,170 more rows, and 5 more variables: weight <dbl>, genus <chr>,
## #   species <chr>, taxa <chr>, plot_type <chr>
```

#### Pipes

What if you want to select and filter at the same time? There are three
ways to do this: use intermediate steps, nested functions, or pipes.

With intermediate steps, you create a temporary data frame and use that
as input to the next function, like this:

``` r
surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)
```

This is readable, but can clutter up your workspace with lots of objects
that you have to name individually. With multiple steps, that can be
hard to keep track of.

You can also nest functions (i.e. one function inside of another), like
this:

``` r
surveys_sml <- select(filter(surveys, weight < 5), species_id, sex, weight)
```

This is handy, but can be difficult to read if too many functions are
nested, as R evaluates the expression from the inside out (in this case,
filtering, then selecting).

The last option, pipes, are a recent addition to R, for those who
familiar with bash scripting probably has experience how to use the
pipe.

Pipes let you take the output of one function and send it directly to
the next, which is useful when you need to do many things to the same
dataset. Pipes in R look like `%>%` (in bash is `|`) and are made
available via the `magrittr` package, installed automatically with
`dplyr`. If you use RStudio, you can type the pipe with **Ctrl** +
**Shift** + **M** in Windows or **Cmd** + **Shift** + **M** if you have
a Mac.

``` r
surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight)
## # A tibble: 17 x 3
##    species_id sex   weight
##    <chr>      <chr>  <dbl>
##  1 PF         F          4
##  2 PF         F          4
##  3 PF         M          4
##  4 RM         F          4
##  5 RM         M          4
##  6 PF         <NA>       4
##  7 PP         M          4
##  8 RM         M          4
##  9 RM         M          4
## 10 RM         M          4
## 11 PF         M          4
## 12 PF         F          4
## 13 RM         M          4
## 14 RM         M          4
## 15 RM         F          4
## 16 RM         M          4
## 17 RM         M          4
```

In the above code, we use the pipe to send the surveys dataset first
through `filter()` to keep rows where weight is less than 5, then
through `select()` to keep only the species\_id, sex, and weight
columns. Since `%>%` takes the object on its left and passes it as the
first argument to the function on its right, we don’t need to explicitly
include the data frame as an argument to the `filter()` and `select()`
functions any more.

If we want to create a new object with this smaller version of the data,
we can assign it a new name:

``` r
surveys_sml <- surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight)
surveys_sml
## # A tibble: 17 x 3
##    species_id sex   weight
##    <chr>      <chr>  <dbl>
##  1 PF         F          4
##  2 PF         F          4
##  3 PF         M          4
##  4 RM         F          4
##  5 RM         M          4
##  6 PF         <NA>       4
##  7 PP         M          4
##  8 RM         M          4
##  9 RM         M          4
## 10 RM         M          4
## 11 PF         M          4
## 12 PF         F          4
## 13 RM         M          4
## 14 RM         M          4
## 15 RM         F          4
## 16 RM         M          4
## 17 RM         M          4
```

**Challenge 1 (10 min)**

> Using pipes, subset the surveys data to include animals collected
> before 1995 and retain only the columns year, sex, and weight.

#### Mutate

Frequently you’ll want to create new columns based on the values in
existing columns, for example to do unit conversions, value
normalization or to find the ratio of values in two columns. For this
we’ll use mutate().

To create a new column of weight in kg:

``` r
surveys %>% 
  mutate(weight_kg = weight / 1000)
## # A tibble: 34,786 x 14
##    record_id month   day  year plot_id species_id sex   hindfoot_length
##        <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>      <chr>           <dbl>
##  1         1     7    16  1977       2 NL         M                  32
##  2        72     8    19  1977       2 NL         M                  31
##  3       224     9    13  1977       2 NL         <NA>               NA
##  4       266    10    16  1977       2 NL         <NA>               NA
##  5       349    11    12  1977       2 NL         <NA>               NA
##  6       363    11    12  1977       2 NL         <NA>               NA
##  7       435    12    10  1977       2 NL         <NA>               NA
##  8       506     1     8  1978       2 NL         <NA>               NA
##  9       588     2    18  1978       2 NL         M                  NA
## 10       661     3    11  1978       2 NL         <NA>               NA
## # … with 34,776 more rows, and 6 more variables: weight <dbl>,
## #   genus <chr>, species <chr>, taxa <chr>, plot_type <chr>,
## #   weight_kg <dbl>
```

You can also create a second new column based on the first new column
within the same call of `mutate()`. If this runs off your screen and you
just want to see the first few rows, you can use a pipe to view the
head() of the data.

``` r
surveys %>% 
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>% 
  head()
```

    ## # A tibble: 6 x 15
    ##   record_id month   day  year plot_id species_id sex   hindfoot_length
    ##       <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>      <chr>           <dbl>
    ## 1         1     7    16  1977       2 NL         M                  32
    ## 2        72     8    19  1977       2 NL         M                  31
    ## 3       224     9    13  1977       2 NL         <NA>               NA
    ## 4       266    10    16  1977       2 NL         <NA>               NA
    ## 5       349    11    12  1977       2 NL         <NA>               NA
    ## 6       363    11    12  1977       2 NL         <NA>               NA
    ## # … with 7 more variables: weight <dbl>, genus <chr>, species <chr>,
    ## #   taxa <chr>, plot_type <chr>, weight_kg <dbl>, weight_lb <dbl>

The first few rows of the output are full of NAs, so if we wanted to
remove those we could insert a filter() in the chain:

``` r
surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight / 1000) %>% 
  head()
```

    ## # A tibble: 6 x 14
    ##   record_id month   day  year plot_id species_id sex   hindfoot_length
    ##       <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>      <chr>           <dbl>
    ## 1       588     2    18  1978       2 NL         M                  NA
    ## 2       845     5     6  1978       2 NL         M                  32
    ## 3       990     6     9  1978       2 NL         M                  NA
    ## 4      1164     8     5  1978       2 NL         M                  34
    ## 5      1261     9     4  1978       2 NL         M                  32
    ## 6      1453    11     5  1978       2 NL         M                  NA
    ## # … with 6 more variables: weight <dbl>, genus <chr>, species <chr>,
    ## #   taxa <chr>, plot_type <chr>, weight_kg <dbl>

`is.na()` is a function that determines whether something is an **NA**.
The `!` symbol negates the result, so we’re asking for every row where
weight is not an NA.

**Challenge 2 (15 min)**

> Create a new data frame from the surveys data that meets the following
> criteria: contains only the species\_id column and a new column called
> hindfoot\_half containing values that are half the hindfoot\_length
> values. In this hindfoot\_half column, there are no NAs and all values
> are less than 30. Hint: think about how the commands should be ordered
> to produce this data frame\!

#### Split-apply-combine data analysis and the summarize() function

Many data analysis tasks can be approached using the
*split-apply-combine* paradigm: split the data into groups, apply some
analysis to each group, and then combine the results. **dplyr** makes
this very easy through the use of the `group_by()` function.

`group_by()` is often used together with summarize(), which collapses
each group into a single-row summary of that group. `group_by()` takes
as arguments the column names that contain the categorical variables for
which you want to calculate the summary statistics. So to compute the
mean weight by sex:

``` r
surveys %>% 
  group_by(sex) %>% 
  summarise(mean_weight = mean(weight,na.rm=TRUE))
## # A tibble: 3 x 2
##   sex   mean_weight
##   <chr>       <dbl>
## 1 F            42.2
## 2 M            43.0
## 3 <NA>         64.7
```

You may also have noticed that the output from these calls doesn’t run
off the screen anymore. It’s one of the advantages of `tbl_df` over data
frame.

You can also group by multiple columns:

``` r
surveys %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight,na.rm=TRUE))
## # A tibble: 92 x 3
## # Groups:   sex [3]
##    sex   species_id mean_weight
##    <chr> <chr>            <dbl>
##  1 F     BA                9.16
##  2 F     DM               41.6 
##  3 F     DO               48.5 
##  4 F     DS              118.  
##  5 F     NL              154.  
##  6 F     OL               31.1 
##  7 F     OT               24.8 
##  8 F     OX               21   
##  9 F     PB               30.2 
## 10 F     PE               22.8 
## # … with 82 more rows
```

When grouping both by sex and species\_id, the last few rows are for
animals that escaped before their sex and body weights could be
determined. You may notice that the last column does not contain NA but
NaN (which refers to “Not a Number”). To avoid this, we can remove the
missing values for weight before we attempt to calculate the summary
statistics on weight. Because the missing values are removed first, we
can omit na.rm = TRUE when computing the mean:

``` r
surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight))
## # A tibble: 64 x 3
## # Groups:   sex [3]
##    sex   species_id mean_weight
##    <chr> <chr>            <dbl>
##  1 F     BA                9.16
##  2 F     DM               41.6 
##  3 F     DO               48.5 
##  4 F     DS              118.  
##  5 F     NL              154.  
##  6 F     OL               31.1 
##  7 F     OT               24.8 
##  8 F     OX               21   
##  9 F     PB               30.2 
## 10 F     PE               22.8 
## # … with 54 more rows
```

Once the data are grouped, you can also summarize multiple variables at
the same time (and not necessarily on the same variable). For instance,
we could add a column indicating the minimum weight for each species for
each sex. We also can sort the value for example based on min\_weight
using `arrange()`

``` r
surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight),
            min_weight = min(weight)) %>% 
  arrange(min_weight)
## # A tibble: 64 x 4
## # Groups:   sex [3]
##    sex   species_id mean_weight min_weight
##    <chr> <chr>            <dbl>      <dbl>
##  1 F     PF                7.97          4
##  2 F     RM               11.1           4
##  3 M     PF                7.89          4
##  4 M     PP               17.2           4
##  5 M     RM               10.1           4
##  6 <NA>  PF                6             4
##  7 F     OT               24.8           5
##  8 F     PP               17.2           5
##  9 F     BA                9.16          6
## 10 M     BA                7.36          6
## # … with 54 more rows
```

To sort in descending order, we need to add the desc() function. If we
want to sort the results by decreasing order of mean weight.

When working with data, we often want to know the number of observations
found for each factor or combination of factors. For this task, dplyr
provides `count()`. For example, if we wanted to count the number of
rows of data for each sex and sort it, we would do:

``` r
surveys %>% 
  count(sex,sort=TRUE)
## # A tibble: 3 x 2
##   sex       n
##   <chr> <int>
## 1 M     17348
## 2 F     15690
## 3 <NA>   1748
```

Previous example shows the use of `count()` to count the number of
rows/observations for one factor (i.e., sex). If we wanted to count
combination of factors, such as sex and species, we would specify the
first and the second factor as the arguments of `count()`:

``` r
surveys %>% 
  count(sex, species_id)
## # A tibble: 92 x 3
##    sex   species_id     n
##    <chr> <chr>      <int>
##  1 F     BA            31
##  2 F     DM          4554
##  3 F     DO          1308
##  4 F     DS          1188
##  5 F     NL           675
##  6 F     OL           475
##  7 F     OT          1057
##  8 F     OX             4
##  9 F     PB          1646
## 10 F     PE           579
## # … with 82 more rows
```

With the above code, we can proceed with `arrange()` to sort the table
according to a number of criteria so that we have a better comparison.
For instance, we might want to arrange the table above in (i) an
alphabetical order of the levels of the species and (ii) in descending
order of the count:

``` r
surveys %>% 
  count(sex, species_id) %>% 
  arrange(species_id, desc(n))
## # A tibble: 92 x 3
##    sex   species_id     n
##    <chr> <chr>      <int>
##  1 <NA>  AB           303
##  2 <NA>  AH           436
##  3 M     AH             1
##  4 <NA>  AS             2
##  5 F     BA            31
##  6 M     BA            14
##  7 <NA>  BA             1
##  8 <NA>  CB            50
##  9 <NA>  CM            13
## 10 <NA>  CQ            16
## # … with 82 more rows
```

**Challenge 3 (20 min)**

> 1.  How many animals were caught in plot\_type surveyed?
> 2.  Use group\_by() and summarize() to find the mean, min, and max
>     hindfoot length for each species (using species\_id). Also add the
>     number of observations (hint: see ?n).
> 3.  What was the heaviest animal measured in each year? Return the
>     columns year, genus, species\_id, and weight.

#### Reshaping the data - Tidying up the data

We have to learn the concept of **Data Tidying** in R to better handle
our data before processing to analysis such as visualizations,
statistical test, aplying functions, and others. We will use **tidyr**
for tidying up our data.

**Key to remember: Tidy data format** \<\<\<\<\<\<\< HEAD

> > 1.  Every column is variable.
> > 2.  Every row is an observation.
> > 3.  Every cell is a single value.

Sometimes, we just want to analyze particular element of the data. To
extract the informations and still make the data tidy, we can reshape
our data according to the observations of interest which could be in
**long** format or **wide** format. You may want to read more
[here](https://tidyr.tidyverse.org/articles/tidy-data.html).

In the previous versions, there are two `tidyr` functions named
`spread()` and `gather()` to help us reshaping our data. In the [data
carperntry
example](https://datacarpentry.org/R-ecology-lesson/03-dplyr.html), you
can see how we can use that functions. In newer version, there are
replacement for `spread()` and `gather()`. `spread()` and `gather()`
will stay there but not in active development. Today, we will use the
replacement named `pivot_wider` and `pivot_longer`.

**Convert long format to wide format**

*Case*: compare the different mean weight of each genus between plots?
(Ignoring plot\_type for simplicity).

\=======

> > 1.  Every column is variable.
> > 2.  Every row is an observation.
> > 3.  Every cell is a single value.

Sometimes, we just want to analyze particular element of the data. To
extract the informations and still make the data tidy, we can reshape
our data according to the observations of interest which could be in
**long** format or **wide** format. You may want to read more
[here](https://tidyr.tidyverse.org/articles/tidy-data.html).

In the previous versions, there are two `tidyr` functions named
`spread()` and `gather()` to help us reshaping our data. In the [data
carperntry
example](https://datacarpentry.org/R-ecology-lesson/03-dplyr.html), you
can see how we can use that functions. In newer version, there are
replacement for `spread()` and `gather()`. `spread()` and `gather()`
will stay there but not in active development. Today, we will use the
replacement named `pivot_wider` and `pivot_longer`.

**Convert long format to wide format**

*Case*: compare the different mean weight of each genus between plots?
(Ignoring plot\_type for simplicity).

> > > > > > > 00801951a2bf581f1a76f3c7307ae88d40679311 *Solution*:
> > > > > > > extract the table so it will contains the name of `genus`
> > > > > > > in the columns, rows is the onservations, and cells
> > > > > > > contains the mean weight for each genus.

Let’s use `pivot_wider` to transform surveys to find the mean weight of
each genus in each plot over the entire survey period. We use
`filter()`, `group_by()` and `summarise()` to filter our observations
and variables of interest, and create a new variable for the
mean\_weight. We use the pipe as before too.

``` r
surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

str(surveys_gw)
## Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':  196 obs. of  3 variables:
##  $ genus      : chr  "Baiomys" "Baiomys" "Baiomys" "Baiomys" ...
##  $ plot_id    : num  1 2 3 5 18 19 20 21 1 2 ...
##  $ mean_weight: num  7 6 8.61 7.75 9.5 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   record_id = col_double(),
##   ..   month = col_double(),
##   ..   day = col_double(),
##   ..   year = col_double(),
##   ..   plot_id = col_double(),
##   ..   species_id = col_character(),
##   ..   sex = col_character(),
##   ..   hindfoot_length = col_double(),
##   ..   weight = col_double(),
##   ..   genus = col_character(),
##   ..   species = col_character(),
##   ..   taxa = col_character(),
##   ..   plot_type = col_character()
##   .. )
##  - attr(*, "groups")=Classes 'tbl_df', 'tbl' and 'data.frame':   10 obs. of  2 variables:
##   ..$ genus: chr  "Baiomys" "Chaetodipus" "Dipodomys" "Neotoma" ...
##   ..$ .rows:List of 10
##   .. ..$ : int  1 2 3 4 5 6 7 8
##   .. ..$ : int  9 10 11 12 13 14 15 16 17 18 ...
##   .. ..$ : int  33 34 35 36 37 38 39 40 41 42 ...
##   .. ..$ : int  57 58 59 60 61 62 63 64 65 66 ...
##   .. ..$ : int  81 82 83 84 85 86 87 88 89 90 ...
##   .. ..$ : int  105 106 107 108 109 110 111 112 113 114 ...
##   .. ..$ : int  128 129 130 131 132 133 134 135 136 137 ...
##   .. ..$ : int  152 153 154 155 156 157 158 159 160 161 ...
##   .. ..$ : int  176 177 178 179 180 181 182 183 184 185 ...
##   .. ..$ : int  195 196
##   ..- attr(*, ".drop")= logi TRUE
```

This yields `surveys_gw` where the observations for each plot are spread
across multiple rows, 196 observations of 3 variables. `pivot_wider`
will “widens” data, increasing the number of columns and decreasing the
number of rows. We will get 24 observations of 11 variables, one row for
each plot. We again use pipes. Let’s also fill the mising value with 0

``` r
surveys_wider <- surveys_gw %>% 
  pivot_wider(names_from= genus, values_from= mean_weight, 
              values_fill = list(mean_weight=0))

str(surveys_wider)
## Classes 'tbl_df', 'tbl' and 'data.frame':    24 obs. of  11 variables:
##  $ plot_id        : num  1 2 3 5 18 19 20 21 4 6 ...
##  $ Baiomys        : num  7 6 8.61 7.75 9.5 ...
##  $ Chaetodipus    : num  22.2 25.1 24.6 18 26.8 ...
##  $ Dipodomys      : num  60.2 55.7 52 51.1 61.4 ...
##  $ Neotoma        : num  156 169 158 190 149 ...
##  $ Onychomys      : num  27.7 26.9 26 27 26.6 ...
##  $ Perognathus    : num  9.62 6.95 7.51 8.66 8.62 ...
##  $ Peromyscus     : num  22.2 22.3 21.4 21.2 21.4 ...
##  $ Reithrodontomys: num  11.4 10.7 10.5 11.2 11.1 ...
##  $ Sigmodon       : num  0 70.9 65.6 82.7 46.1 ...
##  $ Spermophilus   : num  0 0 0 0 0 0 57 0 0 0 ...
```

**Convert wide format to long format**

The opposing situation could occur if we had been provided with data in
the form of `surveys_wide`, where the genus names are column names, but
we wish to treat them as values of a genus variable instead.

In this situation we can reshape it by Keying the column names and
turning them into a pair of new variables. One variable represents the
column names as values, and the other variable contains the values
previously associated with the column names.

To recreate `surveys_gw` from `surveys_wide` we would create a key
called “genus” and value called “mean\_weight” and use all columns
except “plot\_id” for the key variable. Here we drop “plot\_id” column
with a minus sign. We will name our new table as surveys\_longer.

``` r
surveys_longer <- surveys_wider %>% 
  pivot_longer(names_to = "genus", values_to = "mean_weight", -plot_id)
  
str(surveys_longer)
## Classes 'tbl_df', 'tbl' and 'data.frame':    240 obs. of  3 variables:
##  $ plot_id    : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ genus      : chr  "Baiomys" "Chaetodipus" "Dipodomys" "Neotoma" ...
##  $ mean_weight: num  7 22.2 60.2 156.2 27.7 ...
```

**Challenge 4 (20 min)**

> 1.  Spread the surveys data frame with year as columns, plot\_id as
>     rows, and the number of genera per plot as the values. You will
>     need to summarize before reshaping, and use the function
>     n\_distinct() to get the number of unique genera within a
>     particular chunk of data. It’s a powerful function\! See
>     ?n\_distinct for more.
> 2.  Now take that data frame and gather() it again, so each row is a
>     unique plot\_id by year combination.
> 3.  The surveys data set has two measurement columns: hindfoot\_length
>     and weight. This makes it difficult to do things like look at the
>     relationship between mean values of each measurement per year in
>     different plot types. Let’s walk through a common solution for
>     this type of problem. First, use gather() to create a dataset
>     where we have a key column called measurement and a value column
>     that takes on the value of either hindfoot\_length or weight.
>     Hint: You’ll need to specify which columns are being gathered.
> 4.  With this new data set, calculate the average of each measurement
>     in each year for each different plot\_type. Then spread() them
>     into a data set with a column for hindfoot\_length and weight.
>     Hint: You only need to specify the key and value columns for
>     spread().

You can see another example of tidying up the data in example of
[pivot\_longer](https://tidyr.tidyverse.org/reference/pivot_longer.html),
[pivot\_wider](https://tidyr.tidyverse.org/reference/pivot_wider.html),
or complex example
[here](https://www.brodrigues.co/blog/2019-03-20-pivot/).

#### Exporting data

Writing up the data into new file after spreading or gathering may be
needed at some point. We can use the `write_csv()` funtion to generate
the CSV files from the dataframe. if you want to write in the other
delimiter, you can use `write_delim()` instead. Read the options in
`?write_csv` or `?write_delim` for better understanding.

## More exercise

See notebooks here:
<https://www.kaggle.com/rtatman/getting-started-in-r-load-data-into-r>.

## More datasets, more challenge

  - Pokemon Dataset :
    <https://www.kaggle.com/rounakbanik/pokemon/discussion>
  - House Price:
    <https://www.kaggle.com/c/house-prices-advanced-regression-techniques>

## Further Reading

  - The core of R (deep understanding how R work):
    <https://adv-r.hadley.nz/>
  - R for Data Science: <https://r4ds.had.co.nz/>
  - Another source for R for Data Science:
    <https://livebook.datascienceheroes.com/>
  - Rmarkdown for reproducible documentation:
    <https://bookdown.org/yihui/rmarkdown/>
  - R graph cookbook: <https://r-graphics.org/>
  - Feeling gig for Regex (regular expression):
    <http://www.grymoire.com/Unix/Regular.html>
