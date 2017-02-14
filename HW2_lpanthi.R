# This program is written to predict the graduate debt by analyzing each variables in the given set of data.

# Lets first set the working directory to the folder you want to use for this project. I have used my local drive.
setwd("C:/Users/laxpa/Google Drive/Spring 17/MIS64037/R-LinearRegression")
getwd() # confirms the drive you set

# Use the read.csv function to download the csv file directly from the website, change the null values and privacysuppressed values into <NA> and save it as a collegedata object.
CS <- read.csv("https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Scorecard-Elements.csv",na.strings = c("NULL","PrivacySuppressed"))
library(dplyr) #loading the dplyr library just in case
library(tibble) #load the library required for tbl_df function
CS1 <- tbl_df(CS) #saves the CollegeScorecard table as a much better data frame.
dim(CS) #check the dimension of the data frame.
CS2 <- CS[sapply(CS, is.numeric)] #create a new dataframe CS_1 with only numeric values from CS
attach(CS2) #attach file to use the columns
View(CS2)
cor(CS2, use="pairwise.complete.obs")
cor(CS2)