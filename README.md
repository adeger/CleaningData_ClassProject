# CleaningData_ClassProject

This document describes files created for the Coursera course Getting and Cleaning Data class project.

## Files
 - README.md : this file
 - run_analysis.R : script for generating a tidy data frame of means for variables summarized by the 
 - codebook.md : Explanation of variables in the data.frame generated by run_analysis.R

## Base Data/Input
Input data are taken from the zip file at: 
(https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip) 
These files need to be manually unzipped and the R working directory set to the newly-created "UCI HAR Dataset/" directory.  

## Getting output

The simplest way to get output is from the R console:

 - Open R console
 - source("path_to_script/run_analysis.R")
 - results <- do_all()

The resultant data frame will be in object "results" and the file "Acceleration_Data_Means_Summarized_by_Subject&Activity.txt" (a text file capable of being written by read.table()) will be written to the working directory (file will be clobbered if script is rerun)

Using something like Rscript.exe from the command line on Windows is messier but do-able:

 - Open cmd.exe window
 - cd c:\path_to_my_unzipped_data_file\UCI\ HAR\ Dataset
 - "c:\Program Files\R\R-3.2.0\bin\Rscript.exe" -e "source(\\\\"path_to_my/run_analysis.R\\\\")" -e "do_all()"

This should not be broken across lines and the path to your Rscript.exe executable is, of course, machine dependent as is the path to your run_analys.R file.  Note also that on the Windows command line three backslashes are needed to escape the quotes for the file in the -e "source()" construct which is hard to show correctly in markdown (Sheesh!).  As with the R console approach the same file is written to disk.
