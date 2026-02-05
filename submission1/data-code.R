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

#check overall summary w/ graphs for each year to make sure data is right

# recode with variables we're interested in
vars <- c(
"hhi_ma",
"plan_count",
"avg_premium_partc",
"share_pos_premiums",
"avg_bid",
"avg_eligibles",
"ffs_cost"
)

2014_sumary <- dat.2014 %>% 
cols      = all_of(vars),
names_to  = "variable",
values_to = "value"
) %>%
group_by(variable) %>%
summarize(
n_nonmissing = sum(!is.na(value)),
n_missing    = sum(is.na(value)),
mean         = mean(value, na.rm = TRUE),
sd           = sd(value,   na.rm = TRUE),
min          = min(value,  na.rm = TRUE),
max          = max(value,  na.rm = TRUE),
.groups      = "drop"
) %>%
mutate(
variable = recode(
variable,
"hhi_ma"             = "MA HHI",
"plan_count"         = "# of plans",
"avg_premium_partc"  = "Avg Part C premium",
"share_pos_premiums" = "Share with positive premium",
"avg_bid"            = "Avg bid",
"avg_eligibles"      = "Avg eligibles",
"ffs_cost"           = "Avg FFS cost"
),
across(c(mean, sd, min, max), ~round(., 2))
)


na.full <- rbind(dat.2014, dat.2015, dat.2016, dat.2017, dat.2018, dat.2019)

#check if dataset is loaded correctly
str(na.full)

#save na.full as another dataset
write_csv(na.full,"hmwk_data/data_2014-2019.csv")

