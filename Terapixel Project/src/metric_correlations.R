
#calculate correlation coefficient between runtime and temp of each hostname for all tasks
temp_vs_runtime_corr = lapply(unique_hostnames,calculate_corr,var1 = "runtime", var2 = "tempC", task_number = 0)
temp_vs_runtime_corr = unlist(temp_vs_runtime_corr)
mean(temp_vs_runtime_corr)

#calculate correlation coefficient between runtime and temp of each hostname exc first two tasks
temp_vs_runtime_corr2 = lapply(unique_hostnames,calculate_corr,
                               var1 = "runtime", var2 = "tempC", task_number = 2)
temp_vs_runtime_corr2 = unlist(temp_vs_runtime_corr2)
mean(temp_vs_runtime_corr2)

#find number of tasks executed on each virtual machine
vm_weights = lapply(unique_hostnames,function(x) {max(all_data[all_data$hostname == x,]$task_no)})

#plot average temperature for first ten tasks
(temp_vs_task = ggplot(filter(all_data,task_no %in% c(1:10)), aes(x = task_no, y = tempC)) + 
    stat_summary(fun = mean, geom = "line") + 
  labs(
    x = "Task Number",
    y = "Temperature (celsius)",
    title = "Average Temperature per Task"
  ) + 
    scale_x_continuous(breaks = seq(1,20,1)))


#plot scatter plot of vm with negative correlation, showing runtime vs temp
(weak_temp_corr = ggplot(
  filter(all_data,hostname ==
           unique_hostnames[match(min(temp_vs_runtime_corr),
                                                    temp_vs_runtime_corr)] & 
                                  task_no>0),
                          aes(x = tempC, y = runtime)) + 
    geom_point() + 
    geom_text(aes(label = task_no), vjust = 1.2) + 
    labs(
      x = "Temperature (celsius)",
      y = "Runtime (seconds)",
      title = "VM with Negative Correlation"
    ))

#plot scatter plot of vm with strong positive correlation, showing runtime vs temp
(strong_temp_corr = ggplot(filter(all_data,hostname ==unique_hostnames[match(max(temp_vs_runtime_corr),temp_vs_runtime_corr)]),
                         aes(x = tempC, y = runtime)) + geom_point()  + geom_text(aes(label = task_no), vjust = 1.2))

#histogram of correlation coefficient distribiution including first two tasks
(corr_hist = ggplot() + aes(temp_vs_runtime_corr) +
    geom_histogram(bins = 15) + 
    labs(
      x = "Correlation Coefficient",
      y = "Frequency",
      title = "Distribution of Correlation Coefficients"
    ) + 
    coord_cartesian(xlim=c(-0.2,1)))

#histogram of correlation coefficient distribiution excluding first two tasks
(corr_hist2 = ggplot() + aes(temp_vs_runtime_corr2) +
    geom_histogram(bins = 15) + 
    labs(
      x = "Correlation Coefficient",
      y = "Frequency",
      title = "Distribution of Correlation Coefficients Excluding First 2 Tasks"
    ) + 
    coord_cartesian(xlim=c(-0.2,1)))

