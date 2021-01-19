(slow_gpu = ggplot(filter(all_data,gpuSerial == slow_cards$gpuSerial[1]),
                          aes(x = task_no, y = runtime)) + geom_point() + geom_text(aes(label = task_no), 
                                                                                    vjust = 1.2) +
  xlim(0,60) + 
  ylim(20,70))


(slow_card_inc_plot = ggplot(slow_cards[1:30,], 
                            aes(x = reorder(as.factor(gpuSerial),colour_map), 
                                y = avg_runtime, colour = as.factor(colour_map))) + 
  geom_point(aes(shape = runtime_env,size = 5)) + theme(
    axis.text.x = element_text(vjust = 1, hjust = 1,angle = 45)
  ) + labs(
    x = "GPU Serial Number",
    y = "Average Runtime (seconds)"
  ) + guides(colour = FALSE, size = FALSE) + scale_shape_discrete(name = "First 2 tasks included?",
                                                                   labels = c("No","Yes")))


ggplot(arrange(filter(slow_cards,runtime_env == "runtime_exc")), aes(x = as.factor(reorder(gpuSerial,-avg_runtime)), y = avg_runtime)) + 
  geom_point() + theme(axis.title.x=element_blank(),
                       axis.text.x = element_blank(),
                       axis.ticks.x = element_blank())

ggplot(arrange(filter(slow_cards,runtime_env == "runtime_inc"))) + aes(x = avg_runtime) + 
  geom_histogram(bins = 20) + labs(
    x = "Average Total Render Time per Tile per GPU (seconds)",
    y = "Frequency"
  )



mean(avg_diff$runtime_diff)




