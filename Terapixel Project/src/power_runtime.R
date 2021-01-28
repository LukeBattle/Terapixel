
#plot average power draw per task
(power_vs_task = ggplot(all_data, aes(x = task_no, y = powerDraw)) + 
  stat_summary(fun = mean, geom = "line") + 
  labs(
    x = "Task Number",
    y = "Power Draw (watts)"
    
  ) + 
  coord_cartesian(xlim=c(0,10)))

#calculate correlation coefficients between runtime and powerdraw for each virtual machine including 
#first two tasks
power_vs_runtime_corr = lapply(unique_hostnames,calculate_corr,var1 = "runtime", var2 = "powerDraw", 
                               task_number = 0)
power_vs_runtime_corr = unlist(power_vs_runtime_corr)

#scatterplot of random hostname showing power draw vs runtime
(power_corr = ggplot(filter(all_data,hostname ==unique_hostnames[13]),
                          aes(x = powerDraw, y = runtime)) + geom_point() + geom_text(aes(label = task_no), vjust = 1.2))

#scatterplot of of virtual machine with weakest correlation coefficient, showing power draw vs runtime
(weak_power_corr = ggplot(filter(all_data,hostname ==unique_hostnames[match(min(power_vs_runtime_corr),
                                                                            power_vs_runtime_corr)] & 
                                  task_no>0),
                         aes(x = powerDraw, y = runtime)) + geom_point() + geom_text(aes(label = task_no), vjust = 1.2))

#scatterplot of of virtual machine with strongest correlation coefficient, showing power draw vs runtime
(strong_power_corr = ggplot(filter(all_data,hostname ==unique_hostnames[match(max(power_vs_runtime_corr),
                                                                            power_vs_runtime_corr)] & 
                                   task_no>0),
                          aes(x = powerDraw, y = runtime)) + geom_point() + geom_text(aes(label = task_no), vjust = 1.2))


#calculate correlation coefficients between runtime and powerdraw for each virtual machine excluding 
#first two tasks
power_vs_runtime_corr2 = lapply(unique_hostnames,calculate_corr,var1 = "runtime", var2 = "powerDraw", 
                               task_number = 3)
power_vs_runtime_corr2 = unlist(power_vs_runtime_corr2)

#plot distribution of correlation coefficients including first two tasks
(power_corr_hist = ggplot() + aes(power_vs_runtime_corr) +
    geom_histogram(bins = 12) + 
  coord_cartesian(xlim=c(0,1)) +
    labs(
      x = "Correlation Coefficient",
      y = "Frequency",
      title = "Distribution of Correlation Coefficients"
    ))

#plot distribution of correlation coefficients excluding first two tasks
(power_corr_hist2 = ggplot() + aes(power_vs_runtime_corr2) +
    geom_histogram(bins = 12) + 
    coord_cartesian(xlim=c(0,1))+
    labs(
      x = "Correlation Coefficient",
      y = "Frequency",
      title = "Distribution of Correlation Coefficients Excluding First 2 Tasks"
    ))

