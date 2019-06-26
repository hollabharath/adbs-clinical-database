
df<- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/substanceusedisorder_table.csv", header=T)
names(df) <-   c("id", "subjectID", "assessmentId", "test_taken_by", "INTERVIEWERID", "COUNTRY", "CLINIC", "PATIENTID", "DATE", 
                 "Q1a", "Q1b", "Q1c", "Q1d", "Q1e", "Q1f", "Q1g", "Q1h", "Q1i", "Q1j", "Q1j_specify",
                 "Q2a", "Q2b", "Q2c", "Q2d", "Q2e", "Q2f", "Q2g", "Q2h", "Q2i", "Q2j",
                 "Q3a", "Q3b", "Q3c", "Q3d", "Q3e", "Q3f", "Q3g", "Q3h", "Q3i", "Q3j",
                 "Q4a", "Q4b", "Q4c", "Q4d", "Q4e", "Q4f", "Q4g", "Q4h", "Q4i", "Q4j",
                 "Q5b", "Q5c", "Q5d", "Q5e", "Q5f", "Q5g", "Q5h", "Q5i", "Q5j",
                 "Q6a", "Q6b", "Q6c", "Q6d", "Q6e", "Q6f", "Q6g", "Q6h", "Q6i", "Q6j",
                 "Q7a", "Q7b", "Q7c", "Q7d", "Q7e", "Q7f", "Q7g", "Q7h", "Q7i", "Q7j",
                 "Q8",  "deviceid", "date_of_last_update")

# Recode empty cells as zero
df[,10:(ncol(df)-2)][is.na(df[,10:(ncol(df)-2)])] <- 0

# Exclude subjects with incorrect visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9, ]
df <- df[rowSums(nchar(df$assessmentId) ==9, ]
nrow(df_duplicates)
nrow(df)

df$tobacco.score <- rowSums(df[,c("Q2a", "Q3a", "Q4a", "Q6a", "Q7a")], na.rm=TRUE)
df$alcohol.score <- rowSums(df[,c("Q2b", "Q3b", "Q4b", "Q5b", "Q6b", "Q7b")], na.rm=TRUE)
df$cannabis.score <- rowSums(df[,c("Q2c", "Q3c", "Q4c", "Q5c", "Q6c", "Q7c")], na.rm=TRUE)
df$cocaine.score <- rowSums(df[,c("Q2d", "Q3d", "Q4d", "Q5d", "Q6d", "Q7d")], na.rm=TRUE)
df$amphetamine.score <- rowSums(df[,c("Q2e", "Q3e", "Q4e", "Q5e", "Q6e", "Q7e")], na.rm=TRUE)
df$inhalants.score <- rowSums(df[,c("Q2f", "Q3f", "Q4f", "Q5f", "Q6f", "Q7f")], na.rm=TRUE)
df$sedatives.score <- rowSums(df[,c("Q2g", "Q3g", "Q4g", "Q5g", "Q6g", "Q7g")], na.rm=TRUE)
df$hallucinogens.score <- rowSums(df[,c("Q2h", "Q3h", "Q4h", "Q5h", "Q6h", "Q7h")], na.rm=TRUE)
df$opioids.score <- rowSums(df[,c("Q2i", "Q3i", "Q4i", "Q5i", "Q6i", "Q7i")], na.rm=TRUE)
df$other.score <- rowSums(df[,c("Q2j", "Q3j", "Q4j", "Q5j", "Q6j", "Q7j")], na.rm=TRUE)

df$tobacco.level <- as.factor(ifelse(df$tobacco.score==0, "None",ifelse(df$tobacco.score==3, "low",ifelse(df$tobacco.score>=27,"High","Moderate"))))
df$alcohol.level <- as.factor(ifelse(df$alcohol.score==0, "None",ifelse(df$alcohol.score==3, "low",ifelse(df$alcohol.score>=27,"High","Moderate"))))
df$cannabis.level <- as.factor(ifelse(df$cannabis.score==0,"None",ifelse(df$cannabis.score==3,  "low",ifelse(df$cannabis.score>=27,"High","Moderate"))))
df$cocaine.level <- as.factor(ifelse(df$cocaine.score==0,"None",ifelse(df$cocaine.score==3,  "low",ifelse(df$cocaine.score>=27,"High","Moderate"))))
df$amphetamine.level <- as.factor(ifelse(df$amphetamine.score==0,"None",ifelse(df$amphetamine.score==3,  "low",ifelse(df$amphetamine.score>=27,"High","Moderate"))))
df$inhalants.level <- as.factor(ifelse(df$inhalants.score==0,"None",ifelse(df$inhalants.score==3,  "low",ifelse(df$inhalants.score>=27,"High","Moderate"))))
df$sedatives.level <- as.factor(ifelse(df$sedatives.score==0,"None",ifelse(df$sedatives.score==3,  "low",ifelse(df$sedatives.score>=27,"High","Moderate"))))
df$hallucinogens.level <- as.factor(ifelse(df$hallucinogens.score==0,"None",ifelse(df$hallucinogens.score==3,  "low",ifelse(df$hallucinogens.score>=27,"High","Moderate"))))
df$opioids.level <- as.factor(ifelse(df$opioids.score==0,"None",ifelse(df$opioids.score==3,  "low",ifelse(df$opioids.score>=27,"High","Moderate"))))
df$other.level <- as.factor(ifelse(df$other.score==0,"None",ifelse(df$other.score==3,  "low",ifelse(df$other.score>=27,"High","Moderate"))))

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/ASSIST.csv")
