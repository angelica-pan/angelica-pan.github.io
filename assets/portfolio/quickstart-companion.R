####################################################################################
# Companion to "Quickstart Guide for Tidyverse Data Manipulation"
####################################################################################

#########################################
# Section 2. Getting started
#########################################

# Install and load the tidyverse packages
install.packages("tidyverse")
library(tidyverse)

# Install and load the `nycflights13` package
install.packages("nycflights13")
library(nycflights13)

#########################################
# Section 3. tibble
#########################################

# Print the `flights` data frame
flights

#########################################
# Section 4. dplyr
#########################################

# --------------------------------------
# Section 4.1 `select()`
# --------------------------------------

# Select columns by name
select(flights, year, month, day, dep_delay, arr_delay)

# Select columns from `year` to `arr_time` (inclusive)
select(flights, year:arr_time)

# Select all columns except the columns from `year` to `arr_time` (inclusive)
select(flights, -(year:arr_time))

# Rearrange data frame by moving certain columns to the front and moving all other columns to the back
select(flights, dep_delay, arr_delay, everything())

# Select all columns with a name that contains the string "time"
select(flights, contains("time"))

# Exercises
# 1. 
# 2.

# --------------------------------------
# Section 4.2 `filter()`
# --------------------------------------

# Pick out flights that departed on January 1st
filter(flights, month == 1 & day == 1)

# Pick out flights that departed in January, but not flights that departed on January 1st
filter(flights, month == 1 & day != 1)

# Pick out flights that departed in January or in December
filter(flights, month == 1 | month == 12)

# Exercises
# For the following exercises, create a new data frame called `flights2`. 
flights2 <- select(flights, tailnum, starts_with("dep_"), starts_with("arr_"), distance)
# 3. 
# 4. 

# --------------------------------------
# Section 4.3 `mutate()`
# --------------------------------------

# Create a narrower data frame called `flights_narrow` by using `select()`
flights_narrow <- select(flights, year:day, distance, air_time, contains("delay"))

# Create a column called `tot_delay`. Each value is a sum of the`dep_delay` and `arr_delay` values in the same row.
mutate(flights_narrow, tot_delay = dep_delay + arr_delay)

# Create multiple columns at once
mutate(flights_narrow, hours = air_time / 60, speed = distance / hours)

# Modify an existing column
mutate(flights_narrow, distance = 10 - 2)

# Create columns that separate `air_time` into hours and minutes
mutate(flights_narrow, at_hr = air_time %/% 60, at_min = air_time %% 60)

# Create a column that cumulatively sums the arrival delays
mutate(flights_narrow, cum_arr_delay = cumsum(arr_delay))

# Exercises
# 5.
# 6.

# --------------------------------------
# Section 4.4 `arrange()`
# --------------------------------------

# Order flights from least departure delay to most
arrange(flights, dep_delay)

# Order flights from most departure delay to least
arrange(flights, desc(dep_delay))

# --------------------------------------
# Section 4.5 `summarize()`
# --------------------------------------

# Calculate the average departure delay
summarize(flights, avg_delay = mean(dep_delay, na.rm = TRUE))

# Count the number unique departure times
summarize(flights, unique_dep_times = n_distinct(dep_time, na.rm = TRUE))

# --------------------------------------
# Section 4.6 `group_by()`
# --------------------------------------

# Group the data frame by month (12 groups, one for each month)
grouped_df <- group_by(flights, month)
grouped_df

# Ungroup a grouped data frame
ungroup(grouped_df)

#########################################
# Section 5. The pipe operator `%>%`
#########################################

# --------------------------------------
# Section 5.1 Without the pipe
# --------------------------------------

# 1. Pick out flights that departed from JFK
step1 <- filter(flights, origin == "JFK")

# 2. Create a column for total delay times
step2 <- mutate(step1, tot_delay = dep_delay + arr_delay)

# 3. Order flights from most total delay to least
step3 <- arrange(step2, desc(tot_delay))

# 4. Keep only the desired columns
step4 <- select(step3, carrier, dest, distance, air_time, dep_delay, arr_delay, tot_delay)

# View transformed data frame
step4

# --------------------------------------
# Section 5.2 With the pipe
# --------------------------------------

# This code is equivalent to the code in section 5.1
just_1_step <- flights %>%
  filter(origin == "JFK") %>% 
  mutate(tot_delay = dep_delay + arr_delay) %>% 
  arrange(desc(tot_delay)) %>% 
  select(carrier, dest, distance, air_time, dep_delay, arr_delay, tot_delay)

just_1_step

# Exercise
# 7.

#########################################
# Section 6. Grouped dplyr functions
#########################################

# --------------------------------------
# Section 6.1 Grouped summaries
# --------------------------------------

# Calculate the average departure delay, by month
flights %>% 
  group_by(month) %>% 
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE))

# Validate the grouped summary by calculating just the average departure delay for June
flights %>% 
  filter(month == 6) %>% 
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE))

# Calculate the total departure delay by origin and destination, then order rows from most total delay to least
flights %>% 
  group_by(origin, dest) %>% 
  summarize(dep_delay = sum(dep_delay, na.rm = TRUE)) %>% 
  arrange(desc(dep_delay))

# --------------------------------------
# Section 6.2 Grouped filters and mutates
# --------------------------------------

# `n()` is a helper function that returns the size of a group.
# Pick out the 72 destinations that were flown to more than 500 times 
flights %>% 
  group_by(dest) %>% 
  filter(n() > 100)

# Calculate the proportion of a flight's air time to the total airtime of all flights to the same destination
flights %>% 
  select(month, day, origin, dest, dep_time, air_time) %>% 
  group_by(dest) %>% 
  mutate(tot_airtime = sum(air_time, na.rm = TRUE),
         prop_of_tot_airtime = air_time / tot_airtime)
