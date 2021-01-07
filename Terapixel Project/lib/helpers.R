#create function to remove letters from date-time string in data 

clean_date_time = function(string) {
  string_rep = str_replace(string, "T"," ")
  string_rep2 = str_replace(string_rep, "Z","")
  return(string_rep2)
  
}

assign_task_no = function(hostn) {
  filt_data = filter(gpu_data,hostname == hostn)
  data_length = dim(filt_data)[1]
  task_count = 0
  task_no_vector = numeric(data_length)
  for (n in 1:data_length) {
    if (n ==1|n == 2|n == 3) {
      task_no_vector[n] = 0
    } else if (filt_data$gpuMemUtilPerc[n] > 0 & 
               filt_data$gpuUtilPerc[n] > 0 &
               filt_data$gpuMemUtilPerc[n-2] == 0 &
               filt_data$gpuMemUtilPerc[n-1] == 0) {
      task_count = task_count + 1
      task_no_vector[n] = task_count
    } else {task_no_vector[n] = task_count}
  }
  return(task_no_vector)
}

