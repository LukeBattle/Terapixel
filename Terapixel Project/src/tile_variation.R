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
    ))
