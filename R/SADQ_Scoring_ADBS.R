df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/sadq_table.csv", header = T)
names(df) <- c("id", "subjectID", "assessmentId", "test_taken_by", 
               "sadq1", "sadq2", "sadq3", "sadq4", 
               "sadq5", "sadq6", "sadq7", "sadq8", 
               "sadq9", "sadq10", "sadq11", "sadq12", 
               "sadq13", "sadq14", "sadq15", "sadq16", 
               "sadq17", "sadq18", "sadq19", "sadq20",
               "month_year", "year", "score_1_4", "score_5_8", 
               "score_9_12", "score_13_16", "score_17_20",
              "total_score", "deviceid", "date_of_last_update")

# Check for subjects with more than 25% missing data/non response for exclusion 
# Also exclude subjects with incorrect visit ID
df_excluded <- df[rowSums(is.na(df)) > (ncol(df)-10)/4 , ]
df_duplicates <- df[nchar(df$assessmentId) !=9, ]
df <- df[rowSums(is.na(df)) < (ncol(df)-10)/4 & nchar(df$assessmentId) ==9, ]
nrow(df_excluded)
nrow(df_duplicates)
nrow(df)

# Visualize missing data 
VIM::aggr(df[,5:(ncol(df)-10)])

# Compute sub-domain and overall severity scores
df$Physical.Withdrawal <- rowSums(df[,c("sadq1", "sadq2", "sadq3", "sadq4")], na.rm=TRUE)
df$Affective.Withdrawal <- rowSums(df[,c("sadq5", "sadq6", "sadq7", "sadq8")], na.rm=TRUE)
df$Withdrawal.Relief.Drinking <- rowSums(df[,c("sadq9", "sadq10", "sadq11", "sadq12")], na.rm=TRUE)
df$Alcohol.Consumption <- rowSums(df[,c("sadq13", "sadq14", "sadq15", "sadq16")], na.rm=TRUE)
df$Reinstatement.Rapidity <- rowSums(df[,c("sadq17", "sadq18", "sadq19", "sadq20")], na.rm=TRUE)
df$Severity <- df$Physical.Withdrawal + df$Affective.Withdrawal + df$Withdrawal.Relief.Drinking + df$Alcohol.Consumption + df$Reinstatement.Rapidity 
df$Severity.Levels <- ifelse(df$Severity>=31, "Severe", NA)
df$Severity.Levels <- ifelse(df$Severity>16 & df$Severity<31 , "Moderate", df$Severity.Levels)
df$Severity.Levels <- ifelse(df$Severity<16 & df$Severity!=0, "Mild", df$Severity.Levels)
df$Severity.Levels <- ifelse(df$Severity==0, "None", df$Severity.Levels)
df$Severity.Levels <- factor(df$Severity.Levels, levels = c("None", "Mild", "Moderate", "Severe"), ordered = TRUE)

par(mfrow = c(2,3))
plot(hist(df$Physical.Withdrawal))
plot(hist(df$Affective.Withdrawal))
plot(hist(df$Withdrawal.Relief.Drinking))
plot(hist(df$Alcohol.Consumption))
plot(hist(df$Reinstatement.Rapidity))
plot(hist(df$Severity))

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/SADQ.csv")
