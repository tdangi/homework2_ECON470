#load library packages
library(pacman)
p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl, data.table, gdata, scales, kableExtra, modelsummary)
getwd()

#load datasets
dat.2014 <- read_csv("hmwk_data/data-2014.csv")
dat.2015 <- read_csv("hmwk_data/data-2015.csv")
dat.2016 <- read_csv("hmwk_data/data-2016.csv")
dat.2017 <- read_csv("hmwk_data/data-2017.csv")
dat.2018 <- read_csv("hmwk_data/data-2018.csv")
dat.2019 <- read_csv("hmwk_data/data-2019.csv")

#check overall colnames for each year to make sure data is right
datasets <- list(
  "2014" = dat.2014,
  "2015" = dat.2015,
  "2016" = dat.2016,
  "2017" = dat.2017,
  "2018" = dat.2018,
  "2019" = dat.2019
)
colnames_list <- lapply(datasets, colnames)
common_vars <- Reduce(intersect, colnames_list)
common_vars #common variables across all years

#variables unique to each year
unique_vars <- lapply(colnames_list, function(x) {
  setdiff(x, Reduce(intersect, colnames_list))
})
unique_vars #should be 0


#combine all datasets
na.full <- rbind(dat.2014, dat.2015, dat.2016, dat.2017, dat.2018, dat.2019)

#check if dataset is loaded correctly
str(na.full)

#clean year column and merge into one column
names(na.full)[grepl("year", names(na.full))]
tail(na.full[, c("year.x", "year.y", "year.x.x", "year.y.y")]) #all the same

#save na.full as another dataset
write_csv(na.full,"hmwk_data/data_2014-2019.csv")

