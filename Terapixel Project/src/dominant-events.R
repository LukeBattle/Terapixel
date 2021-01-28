
#barplot of median runtime per event
(event_runtime_plot  = ggplot(data = event_plot_data, aes(x = reorder(eventName,runtime),eventName, 
                                                          y = runtime, fill = eventName)) +  
  geom_col(show.legend = FALSE) + 
  geom_text(aes(label = format(round(runtime,2))),vjust = -0.5) +
  labs(
    x = "Event Name",
    y = "Event Runtime (seconds)",
    title = "Event Name vs Runtime"
  )) + theme_minimal()


#histogram of tiling event runtime distribution
(tiling_runtime_hist = ggplot(filter(app_wide,eventName == "Tiling")) +
  geom_histogram(aes(x = as.numeric(runtime)), bins = 30) +
    labs(
      x = "Task Runtime (Seconds)",
      y = "Frequency of Task",
      title = "Tiling Event vs Runtime"
    ))

#histogram of uploading event runtime distribution
(uploading_runtime_hist = ggplot(filter(app_wide,eventName == "Uploading")) +
    geom_histogram(aes(x = as.numeric(runtime)), bins = 30) +
    labs(
      x = "Task Runtime (Seconds)",
      y = "Frequency of Task",
      title = "Uploading Event vs Runtime"
    ))

#histogram of saving config event runtime distribution
(saving_runtime_hist = ggplot(filter(app_wide,eventName == "Saving Config")) +
    geom_histogram(aes(x = as.numeric(runtime)), bins = 30) +
    labs(
      x = "Task Runtime (Seconds)",
      y = "Frequency of Task",
      title = "Saving Config Event vs Runtime"
    ))

#histogram of render event runtime distribution
(render_runtime_hist = ggplot(filter(app_wide,eventName == "Render")) +
    geom_histogram(aes(x = as.numeric(runtime)), bins = 30) +
    labs(
      x = "Task Runtime (Seconds)",
      y = "Frequency of Task",
      title = "Render Event vs Runtime"
    ))

#histogram of totalrender event runtime distribution
(totalrender_runtime_hist = ggplot(filter(app_wide,eventName == "TotalRender")) +
    geom_histogram(aes(x = as.numeric(runtime)), bins = 30))

#tiler app_wide by eventName "Uploading" and runtime longer than 10 seconds and join with task.x.y 
#to get corresponding tile co-ords
high_uploading_runtime = filter(app_wide,runtime>10 & eventName == "Uploading") %>%
  left_join(task.x.y,by = c("taskId"))


#plot tiles with uploading event runtimes of longer than 10 seconds
(uploading_runtime_plot  = ggplot(data = filter(high_uploading_runtime, level == 12), 
                                  aes(x = x, y = y)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "Tiles with High Runtimes",
      color = "Task Number"
    ))


#plot barplot of task numbers for tiles with high uploading event runtimes
(task_no_uploading = ggplot(high_uploading_runtime, aes(x = task_no)) +
  geom_bar() + labs(
    x = "Task Number",
    y = "Frequency",
    title = "Frequency of Task Numbers"
  )) 



