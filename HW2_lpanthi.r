# This program is written to predict the graduate debt by analyzing each variables in the given set of data. load the libraries required to perform the analysis. Please install using install.package("package_name") if not available.
library(mice)
library(dplyr)
library(tibble)

# First we will have to read the data from the college scorecard data and save it as a R object so that we can work on it in R.
CS <- read.csv("https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Scorecard-Elements.csv",na.strings = c("NULL","PrivacySuppressed"))
dim(CS) # Check the row and column size of the object created from the csv file.
summary(CS) # The summary function would give an overview of each columns.

CS_df <- tbl_df(CS) #Convert the original dataset into a data frame and save as another object.
dim(CS_df) #To check the dimension of the dataframe thus created. Same dimension
summary(CS)
summary(CS_df) #Summary of the dataframe shows the measures of each column. There are text columns for which the summary are not available. We do not need them for analysis.

# Now we will create a new data frame with only numerical values. The second function will attach the column names to the session so that we can use column names.
CS_df_num <- CS_df[sapply(CS_df, is.numeric)]
dim(CS_df_num) # gives the dimension of only numerical columns
summary(CS_df_num) # summarise the data. We see a lot of NA presence in the dataframe.
cor(CS_df_num) # The correlation matrix for this data frame does not show any exciting results.

# delete columns with more than 50% missings
miss_col <- c()
for(i in 1:ncol(CS_df_num)) {
  if(length(which(is.na(CS_df_num[,i]))) > 0.5*nrow(CS_df_num)) miss_col <- append(miss_col,i) 
}
CS_df_num_col50 <- CS_df_num[,-miss_col]
dim(CS_df_num_col50) # columns reduced considerably.
summary(CS_df_num_col50) # summary shows the NA's has been removed considerably.
cor(CS_df_num_col50) # The correlation matrix for the resultant dataframe does not show any exciting results either.


# delete rows with NA data in the GRAD_DEBT_MDN_SUPP column.
completeFun <- function(data, desiredCols)
    {
    completeVec <- complete.cases(data[, desiredCols])
    return(data[completeVec, ])
    }
CS_df_num_col50_1 <- completeFun(CS_df_num_col50, "GRAD_DEBT_MDN_SUPP")
dim(CS_df_num_col50_1)
summary(CS_df_num_col50_1)
cor(CS_df_num_col50_1)

# Performing analysis to see the pattern of NA data in the original dataframe and other subsequent dataframes.
md.pattern(CS_df_num)
md.pattern(CS_df_num_col50)
md.pattern(CS_df_num_col50_1)


# Creating a data frame that will extract the complete cases from the dataframe.
CS_df_num_col50_2 <- CS_df_num[complete.cases(CS_df_num_col50), ]
dim(CS_df_num_col50_2)
summary(CS_df_num_col50_2)
cor(CS_df_num_col50_2)