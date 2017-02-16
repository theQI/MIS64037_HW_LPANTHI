
# 1. You are accessing this file from the GitHub repository.

# 2. The following command will download the file to the object CR, with the Null values changed to <NA>.
CR <- read.csv("https://data.baltimorecity.gov/api/views/wsfq-mvij/rows.csv?accessType=DOWNLOAD", header = T, na.strings = c(" ", ""))
summary(CR)

#3. Load the libraries required to summarize data.
library("dplyr")
library("tibble")

# Saving the data in CR table in tibble format as CR_df object. Examples of commands that can be used in this data frame to follow.
CR_df <- tbl_df(CR)
dim(CR_df)
summary(CR_df)

# There are two columns with numerical values. We will find out the mean and SD for each columns.
summarise(CR_df, AveragePost=mean(Post, na.rm=T), AverageIncident=mean(Total.Incidents, na.rm=T))
summarise(CR_df, SDPost=sd(Post, na.rm=T), SDIncident=sd(Total.Incidents, na.rm=T))

# The below command would automatically find the numerical columns and find mean and Sd respectively
sapply(CR_df[sapply(CR_df,is.numeric)],mean,na.rm=T) # Gives the means for numerical column Cr_df
sapply(CR_df[sapply(CR_df,is.numeric)],sd,na.rm=T) # Gives the standard deviation for numerical column in CR_df

# 4. To find the means and standard deviation by Crime Data group by selecting each numerical columns.
summarise(group_by(CR_df, CrimeCode), AveragePost = mean(Post, na.rm=T), AverageIncidents = mean(Total.Incidents, na.rm=T), SD.Post = sd(Post, na.rm=T), SD.Incidents = sd(Total.Incidents, na.rm=T))

# 5. The following commands will count the total incidents by district and crimecode
by_crimecode <- group_by(CR_df, CrimeCode)
by_crimecode %>% count(Total.Incidents, sort = TRUE)
by_District <- group_by(CR_df, District)
by_District %>% count(Total.Incidents, sort = TRUE)

# 6. Count the number of incidents in cross tabing Crimecode with Weapon and district
xtabs(Total.Incidents ~ CrimeCode+Weapon,CR_df) %>% ftable()
xtabs(Total.Incidents ~ CrimeCode+District,CR_df) %>% ftable()
