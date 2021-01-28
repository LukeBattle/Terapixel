CSC8634 Project

Deliverables:

Abstract - entitled "CSC8634 Structured Abstract Michael Luke Battle 200725640.pdf"
-- located in the same directory as this README file

Written Report - entitled "CSC8634 Written Report Michael Luke Battle 200725640.pdf"
-- located in the same directory as this README file

Project Report - entitled "Terapixel-Project-Michael-Luke-Battle.pdf"
--located in "Terapixel\Terapixel Project\reports"

Shiny App - entitled "CSC8634-Results-App"
-- located in "Terapixel\Terapixel Project"
-- run application once project has been loaded

Git Logs - entitled "[200725640]GitLogFile.txt
-- located in the same directory as this README file

This project rigorously evaluates the terapixel rendering process using cloud 
supercomputing. The data has been provided by Newcastle University in
three csv files located in the data sub-directory. All files have been 
used in the analysis.

To load this project, you'll first need to `setwd()` into the directory
where "CSC8634-Results-App" is located, in the "Terapixel Project" directory. 
Then, you need to run the following two lines of R code:

	library('ProjectTemplate')
	load.project()

If you want to add any new files to this data 
analysis pipeline, please ensure that the both the file name is in the same
format and the variables are the same as they are in the files currently in the
data sub-directory, 

In the munge sub-directory:

  01-app_data.R is the data preparation file for the "application.checkpoints" data
  
  02-gpu_data.R is the data preparation file for the "gpu" data

  03-task_data.R is the data preparation file for the "task.x.y" data

In the src sub-directory:

  dominant-events.R
   -- constructs plots and performs analysis relating to the 
      eventName variable in "application.checkpoints"
  
  eda_plots.R 
  -- plots distribiutions of the numeric variables in the data sets, and constructs
     plots that enhance surface understanding of the data sets 
  
  gpu_analysis.R 
  -- plots examining perpetually slow GPU cards

  metric_correlations.R
  -- plots looking at the interplay between temperature and runtime, as well as
     calculation of correlation coefficients between these variables

  power_runtime.R
  -- plots looking at the interplay between power draw and runtime, as well as
     calculation of correlation coefficients between these variables

  tile_variation.R
  -- plots displaying the variation of different performance metrics over the tiles
     and construction of summary table
  
In the lib sub-directory:

  helpers.R
  -- contains all custom functions used in the data analysis pipeline
  
In the reports sub-directory:

  rmarkdown report on project and pdf file associated with this
  
In the data sub-directory:

  data files used in project

In the images sub-directory:
  
  images used in the project report and key plots for abstract	 

In the www sub-directory:
  
  terapixel image to be displayed in shiny app