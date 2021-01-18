(event_runtime_plot  = ggplot(data = event_plot_data, aes(x = reorder(eventName,runtime),eventName, 
                                                          y = runtime, fill = eventName)) +  
  geom_col(show.legend = FALSE) + 
  geom_text(aes(label = format(round(runtime,2))),vjust = -0.5) +
  labs(
    x = "Event Name",
    y = "Event Runtime (seconds)",
    title = "Event Name vs Runtime"
  )) + theme_minimal()

(event_runtime_boxplot  = ggplot(data = app_wide,aes(x = reorder(eventName,runtime),eventName, y = runtime, fill = eventName)) +  
    geom_boxplot(show.legend = FALSE)  +
    labs(
      x = "Event Type",
      y = "Seconds",
      title = "Event Name vs Runtime (Seconds)"
    ))


(tiling_runtime_hist = ggplot(filter(app_wide,eventName == "Tiling")) +
  geom_histogram(aes(x = as.numeric(runtime)), bins = 30) +
    labs(
      x = "Task Runtime (Seconds)",
      y = "Frequency of Task",
      title = "Tiling Event vs Runtime"
    ))

    

(uploading_runtime_hist = ggplot(filter(app_wide,eventName == "Uploading")) +
    geom_histogram(aes(x = as.numeric(runtime)), bins = 30) +
    labs(
      x = "Task Runtime (Seconds)",
      y = "Frequency of Task",
      title = "Uploading Event vs Runtime"
    ))

(saving_runtime_hist = ggplot(filter(app_wide,eventName == "Saving Config")) +
    geom_histogram(aes(x = as.numeric(runtime)), bins = 30) +
    labs(
      x = "Task Runtime (Seconds)",
      y = "Frequency of Task",
      title = "Saving Config Event vs Runtime"
    ))


(render_runtime_hist = ggplot(filter(app_wide,eventName == "Render")) +
    geom_histogram(aes(x = as.numeric(runtime)), bins = 30) +
    labs(
      x = "Task Runtime (Seconds)",
      y = "Frequency of Task",
      title = "Render Event vs Runtime"
    ))

(totalrender_runtime_hist = ggplot(filter(app_wide,eventName == "TotalRender")) +
    geom_histogram(aes(x = as.numeric(runtime)), bins = 30))

high_uploading_runtime = filter(app_wide,runtime>10 & eventName == "Uploading") %>%
  left_join(task.x.y,by = c("taskId")) %>%
  left_join(all_data[c("taskId","task_no")], by = c("taskId"))


(uploading_runtime_plot  = ggplot(data = filter(high_uploading_runtime, level == 12), 
                                  aes(x = x, y = y)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "",
      color = "Task Number"
    ))


(task_no_uploading = ggplot(high_uploading_runtime, aes(x = task_no)) +
  geom_bar() + labs(
    x = "Task Number",
    y = "Frequency",
    title = "Frequency of Task Numbers"
  )) 


