vm_wait_data = as.data.frame(cbind("hostname" = unique_hostnames,vm_waiting_times)) %>%
  left_join(filter(slow_cards,runtime_env == "runtime_exc"),by = c("hostname"))

cor(as.numeric(vm_wait_data$vm_waiting_times),as.numeric(vm_wait_data$avg_runtime))
vm_wait_data$avg_runtime

class(vm_wait_data$vm_waiting_times)

class(vm_wait_data$avg_runtime)
