#create function to remove letters from date-time string in data 

clean_date_time = function(string) {
  string_rep = str_replace(string, "T"," ")
  string_rep2 = str_replace(string_rep, "Z","")
  return(string_rep2)
  
}

