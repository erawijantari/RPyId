Answer for problem in Let’s make it functional part 1: R series
================

**Problem 1**

  - What is the class of the object “surveys” ? Answer:

<!-- end list -->

``` r
surveys <- read.csv("data_raw/portal_data_joined.csv")
class(surveys)
```

    ## [1] "data.frame"

  - How many rows and how many columns are in this object?

<!-- end list -->

``` r
dim(surveys)
```

    ## [1] 34786    13

  - How many species have been recorded during these surveys?

<!-- end list -->

``` r
length(unique(surveys$species))
```

    ## [1] 40

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4816d08570fa10fb298ef35c5b49f6eedc79b9f3
**Problem 2**

1.  Create a `data.frame` (surveys\_200) containing only the data in row
    200 of the surveys dataset.

<!-- end list -->
<<<<<<< HEAD
=======
=======
**Problem 2** 1. Create a `data.frame` (surveys\_200) containing only
the data in row 200 of the surveys dataset.
>>>>>>> e31bd9697beedaf835f301c4945cd90da72d79bc
>>>>>>> 4816d08570fa10fb298ef35c5b49f6eedc79b9f3

``` r
surveys_200 <- surveys[200, ]
surveys_200
```

    ##     record_id month day year plot_id species_id sex hindfoot_length weight
    ## 200     35212    12   7 2002       2         NL   M              33    248
    ##       genus  species   taxa plot_type
    ## 200 Neotoma albigula Rodent   Control

2.  Notice how `nrow()` gave you the number of rows in a `data.frame`?

<!-- end list -->

  - Use that number to pull out just that last row in the data frame.
  - Compare that with what you see as the last row using tail() to make
    sure it’s meeting expectations.
  - Pull out that last row using nrow() instead of the row number.
  - Create a new data frame (surveys\_last) from that last row.

<!-- end list -->

``` r
last_row <- nrow(surveys)
surveys_last <- surveys[last_row, ]
surveys_last
```

    ##       record_id month day year plot_id species_id sex hindfoot_length
    ## 34786     30986     7   1 2000       7         PX                  NA
    ##       weight       genus species   taxa        plot_type
    ## 34786     NA Chaetodipus     sp. Rodent Rodent Exclosure

3.  Use nrow() to extract the row that is in the middle of the data
    frame. Store the content of this row in an object named
    surveys\_middle.

<!-- end list -->

``` r
surveys_middle <- surveys[c(last_row / 2 - 1, last_row / 2) , ]
surveys_middle
```

    ##       record_id month day year plot_id species_id sex hindfoot_length
    ## 17392     31066     7   2 2000      14         DX                  NA
    ## 17393      9828     1  19 1985      14         AB                  NA
    ##       weight      genus   species   taxa plot_type
    ## 17392     NA  Dipodomys       sp. Rodent   Control
    ## 17393     NA Amphispiza bilineata   Bird   Control

4.  Combine nrow() with the - notation above to reproduce the behavior
    of head(surveys), keeping just the first through 6th rows of the
    surveys
    dataset.

<!-- end list -->

``` r
surveys[-c(7:last_row), ]
```

    ##   record_id month day year plot_id species_id sex hindfoot_length weight
    ## 1         1     7  16 1977       2         NL   M              32     NA
    ## 2        72     8  19 1977       2         NL   M              31     NA
    ## 3       224     9  13 1977       2         NL                  NA     NA
    ## 4       266    10  16 1977       2         NL                  NA     NA
    ## 5       349    11  12 1977       2         NL                  NA     NA
    ## 6       363    11  12 1977       2         NL                  NA     NA
    ##     genus  species   taxa plot_type
    ## 1 Neotoma albigula Rodent   Control
    ## 2 Neotoma albigula Rodent   Control
    ## 3 Neotoma albigula Rodent   Control
    ## 4 Neotoma albigula Rodent   Control
    ## 5 Neotoma albigula Rodent   Control
    ## 6 Neotoma albigula Rodent   Control

Alternative to show the table, you can use `View()` which will show the
table in new tab in Rstudio.
