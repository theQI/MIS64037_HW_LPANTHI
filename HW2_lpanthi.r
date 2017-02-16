
# This program is written to predict the graduate debt by analyzing each variables in the given set of data.

# First we will have to read the data from the college scorecard data and save it as a R object so that we can work on it in R.
CS <- read.csv("https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Scorecard-Elements.csv",na.strings = c("NULL","PrivacySuppressed"))
CS
dim(CS)

# To start with the analysis, first the required library are installed and loaded.
library(dplyr)
library(tibble)

# We will covert the data into a more easy to use dataframe.
CS_df <- tbl_df(CS)
CS_df
dim(CS_df)
summary(CS_df)

# Now we will create a new data frame with only numerical values. The second function will attach the column names to the session so that we can use column names.
CS_df_num <- CS_df[sapply(CS_df, is.numeric)]
CS_df_num
dim(CS_df_num)
summary(CS_df_num)

# delete columns with more than 50% missings
miss_col <- c()
for(i in 1:ncol(CS_df_num)) {
  if(length(which(is.na(CS_df_num[,i]))) > 0.5*nrow(CS_df_num)) miss_col <- append(miss_col,i) 
}
CS_df_num_col50 <- CS_df_num[,-miss_col]
summary(CS_df_num_col50)
# summary shows the NA's has been removed considerably
    

# Performing the preliminary correllation between the columns
cor(CS_df_num)

# the correlation matrix shows no correlation between the columns.




