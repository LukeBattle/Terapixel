(power_vs_task = ggplot(all_data, aes(x = task_no, y = powerDraw)) + 
  stat_summary(fun = mean, geom = "line") + 
  labs(
    x = "Task Number",
    y = "Power Draw (watts)"
    
  ))

power_vs_runtime_corr = lapply(unique_hostnames,calculate_corr,var1 = "runtime", var2 = "powerDraw", 
                               task_number = 0)

power_vs_runtime_corr = unlist(power_vs_runtime_corr)

mean(power_vs_runtime_corr)

(power_corr = ggplot(filter(all_data,hostname ==unique_hostnames[13]),
                          aes(x = powerDraw, y = runtime)) + geom_point() + geom_text(aes(label = task_no), vjust = 1.2))


(weak_power_corr = ggplot(filter(all_data,hostname ==unique_hostnames[match(min(power_vs_runtime_corr),
                                                                            power_vs_runtime_corr)] & 
                                  task_no>0),
                         aes(x = powerDraw, y = runtime)) + geom_point() + geom_text(aes(label = task_no), vjust = 1.2))


(strong_power_corr = ggplot(filter(all_data,hostname ==unique_hostnames[match(max(power_vs_runtime_corr),
                                                                            power_vs_runtime_corr)] & 
                                   task_no>0),
                          aes(x = powerDraw, y = runtime)) + geom_point() + geom_text(aes(label = task_no), vjust = 1.2))


power_vs_runtime_corr2 = lapply(unique_hostnames,calculate_corr,var1 = "runtime", var2 = "powerDraw", 
                               task_number = 3)

power_vs_runtime_corr2 = unlist(power_vs_runtime_corr2)

mean(power_vs_runtime_corr2)

(power_corr_hist = ggplot() + aes(power_vs_runtime_corr) +
    geom_histogram(bins = 12))