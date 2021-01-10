cor(as.numeric(all_data[all_data$hostname == "04dc4e9647154250beeee51b866b0715000000",]$runtime),
    all_data[all_data$hostname == "04dc4e9647154250beeee51b866b0715000000",]$tempC)

cor(as.numeric(all_data$runtime),
    all_data$tempC)

calculate_corr = function(hostn,var1,var2) {
  filt_data = filter(all_data,hostname == hostn)
  return(cor(filt_data[c(var1)],filt_data[c(var2)]))
}

hostname_corr = lapply(unique_hostnames,calculate_corr,var1 = "runtime", var2 = "tempC")

(corr_hist = ggplot() + aes(hostname_corr)
    geom_histogram(bins = 30))

