
# Preparing the data before 
library(mice)
library(dplyr)
library(tibble)
library(psych)
CS <- read.csv("https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Scorecard-Elements.csv",na.strings = c("NULL","PrivacySuppressed"))
CS_df <- tbl_df(CS)
CS_df_num <- CS_df[sapply(CS_df, is.numeric)]
miss_col <- c()
for(i in 1:ncol(CS_df_num)) {
  if(length(which(is.na(CS_df_num[,i]))) > 0.5*nrow(CS_df_num)) miss_col <- append(miss_col,i) 
}
CS_df_num_col50 <- CS_df_num[,-miss_col]
completeFun <- function(data, desiredCols)
    {
    completeVec <- complete.cases(data[, desiredCols])
    return(data[completeVec, ])
    }
CS_df_num_col50_1 <- completeFun(CS_df_num_col50, "GRAD_DEBT_MDN_SUPP")
CS_df_num_col50_2 <- CS_df_num_col50[complete.cases(CS_df_num_col50), ]

head(CS_df_num_col50_2, 3)

fit <- princomp(CS_df_num_col50_2, cor=T)
summary(fit)

fit$loadings

loadings(fit) # pc loadings

plot(fit,type="lines") # scree plot

fit$scores # the principal components

biplot(fit)


