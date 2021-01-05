#create dataset with just totalrender events

totalrender_data = filter(app_wide,eventName == "TotalRender")

#create tibble of gpu dataset

gpu_data = as_tibble(gpu)

#create list of clean date_times from gpu dataset

gpu_timestamp = lapply(gpu$timestamp,clean_date_time)

#convert character data_time to datetime format

gpu_datetime = parse_date_time(gpu_timestamp,"%Y%m%d %H%M%S")

#create START variable with formatted datetimes to merge with totalrender_data dataset

gpu_data$START = gpu_datetime

cache('gpu_data')

#merge gpu_data and totalrender_data based on START/STOP and hostname

gpu_app_data = merge(totalrender_data,gpu_data[c("START","hostname","powerDrawWatt","gpuSerial","gpuTempC","gpuUtilPerc","gpuMemUtilPerc")],by = c("START","hostname"))

cache('gpu_app_data')

#create summary of gpu cards by serial number with averages for properties such as runtime, powerdrain, temp
##etc.

gpu_card_summary = gpu_app_data %>%
  group_by(gpuSerial,hostname) %>%
  summarise(runtime = mean(runtime),
            powerdrain = mean(powerDrawWatt),
            temp = mean(gpuTempC),
            memutil = mean(gpuMemUtilPerc),
            gpuutil = mean(gpuUtilPerc)) %>%
  arrange(desc(runtime))



cache('gpu_card_summary')
