#create function to remove letters from date-time string in data 

clean_date_time = function(string) {
  string_rep = str_replace(string, "T"," ")
  string_rep2 = str_replace(string_rep, "Z","")
  return(string_rep2)
  
}

#function to assign task_no to gpu data when ordered chronologically
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

#calculates percentage of observations with gpuMemUtilPerc = 0 and gpuUtilPerc = 0 in gpu data in period from
#beginning of first task to end of final task for a virtual machine
waiting_time_perc = function(hostn) {
  filt_data = filter(gpu_data,hostname == hostn & task_no != 0)
  last_task_ref = min(which(filt_data$task_no == max(filt_data$task_no) & filt_data$gpuMemUtilPerc == 0))-1
  filt_data = slice(filt_data,1:last_task_ref)
  perc_zero = sum(filt_data$gpuMemUtilPerc == 0 & filt_data$gpuUtilPerc == 0)/dim(filt_data)[1] *100
  return(perc_zero)
}

#returns task_no when totalrender_data is ordered for each virtual machine task
assign_tr_task = function(hostn) {
  host_no = sum(totalrender_data$hostname == hostn)
  return(1:host_no)
}

#calculate correlation coefficient between two variables (set as arguments) for chosen virtual machine
calculate_corr = function(hostn,var1,var2, task_number = 0) {
  filt_data = filter(all_data,hostname == hostn & task_no > task_number)
  return(cor(filt_data[c(var1)],filt_data[c(var2)]))
}


#finds the difference in event START times for a specific task inputted as argument
find_event_start_diff = function(task_Id) {
  
  return(app_wide[app_wide$taskId == task_Id & app_wide$eventName == "Uploading","START"] - 
           app_wide[app_wide$taskId == task_Id & app_wide$eventName == "Tiling","START"])
}

