
temp_vs_runtime_corr = lapply(unique_hostnames,calculate_corr,var1 = "runtime", var2 = "tempC", task_number = 0)

temp_vs_runtime_corr = unlist(temp_vs_runtime_corr)

mean(temp_vs_runtime_corr)

temp_vs_runtime_corr2 = lapply(unique_hostnames,calculate_corr,var1 = "runtime", var2 = "tempC", task_number = 2)

temp_vs_runtime_corr2 = unlist(temp_vs_runtime_corr2)

mean(temp_vs_runtime_corr2)

max(temp_vs_runtime_corr2)

temp_vs_task = ggplot(all_data, aes(x = task_no, y = tempC)) + stat_summary(fun = mean, geom = "line") + 
  labs(
    x = "Task Number",
    y = "Temperature (Celsius)"
    
  )

(weak_temp_corr = ggplot(filter(all_data,hostname ==unique_hostnames[match(min(temp_vs_runtime_corr),temp_vs_runtime_corr)] & 
                                  task_no>0),
                          aes(x = tempC, y = runtime)) + geom_point() + geom_text(aes(label = task_no), vjust = 1.2))

(strong_temp_corr = ggplot(filter(all_data,hostname ==unique_hostnames[match(max(temp_vs_runtime_corr),temp_vs_runtime_corr)]),
                         aes(x = tempC, y = runtime)) + geom_point()  + geom_text(aes(label = task_no), vjust = 1.2))

(median_temp_corr = ggplot(filter(all_data,hostname ==unique_hostnames[match(sort(temp_vs_runtime_corr)[512],temp_vs_runtime_corr)]),
                           aes(x = tempC, y = runtime)) + geom_point() + geom_text(aes(label = task_no), vjust = 1.2))

(corr_hist = ggplot() + aes(temp_vs_runtime_corr) +
    geom_histogram(bins = 12))






