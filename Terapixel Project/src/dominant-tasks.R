library(tidyverse)
library(lubridate)
library(parallel)
str(application.checkpoints)
#check NAs

sum(is.na.data.frame(application.checkpoints))

str(application.checkpoints)

app_data = as_tibble(application.checkpoints)


clean_date_time = function(string) {
  string_rep = str_replace(string, "T"," ")
  string_rep2 = str_replace(string_rep, "Z","")
  return(string_rep2)

}

test_string = lapply(application.checkpoints$timestamp,clean_date_time)

op = options(digits.secs = 3)

#use options(op) to reset options

date_time = parse_date_time(test_string,"%Y%m%d %H%M%S")

app_data$timestamp = date_time

app_data = unique(app_data)

app_wide = app_data %>%
  pivot_wider(names_from = eventType,
              values_from = timestamp)

app_wide$runtime = app_wide$STOP - app_wide$START

event_runtime_plot  = ggplot(data = app_wide, aes(x = eventName, y = runtime)) +  
    stat_summary(fun = mean, geom = "col") +
    labs(
      x = "Event Type",
      y = "Seconds",
      title = "Event Name vs Runtime (Seconds)"
    )

event_runtime_plot



