(tile_runtime_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = runtime)) +
  geom_point() +
  labs(
    x = "x",
    y = "y",
    title = "",
    color = "Runtime (seconds)"
  ))

(tile_mem_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = MemUtilPerc)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "",
      color = "% RAM Used"
    ) + scale_color_gradient2(midpoint=mean(filter(all_data,level == 12)$MemUtilPerc), low="green", mid="yellow",
                              high="red", space ="Lab"))

(tile_gpu_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = GpuUtilPerc)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "",
      color = "% RAM Used"
    ) + scale_color_gradient2(midpoint=median(filter(all_data,level == 12)$GpuUtilPerc), low="green", mid="yellow",
                               high="red", space ="Lab"))
