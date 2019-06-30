df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/modified_kuppuswamy_table.csv", header = T)

names(df) <- c("id", "subjectID", "assessmentId", "test_taken_by",
               "education", "occupation", "Income", 
               "deviceid", "date_of_last_update", "stotal")

# Check for subjects with missing data/non response for exclusion 
df_excluded <- df[rowSums(is.na(df[,5:7])) ==3 , ]

# Also check for subjects with incorrect subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | 
                      df$subjectID >200000 | 
                      duplicated(df$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
df <- df[rowSums(is.na(df[,5:7])) !=3 & 
           nchar(df$assessmentId) ==9 & 
           df$subjectID <200000 & 
           !duplicated(df$assessmentId, fromLast = T), ]

paste("SES")
paste("Number of subjects with complete missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(df[,5:7])

# Impute using median of entire sample (Optional)
df[] <- lapply(df, function(x) ifelse(is.na(x), median(x, na.rm = TRUE), x))

# Calculate SES Score and Class
df$SES_Score <- rowSums(df[, c("education", "occupation", "Income")], na.rm = T)
df$SES_Class <- ifelse(df$SES_Score>=26,"Upper",
                       ifelse(df$SES_Score<=25 & df$SES_Score>=16 ,"Upper Middle",
                              ifelse(df$SES_Score<=15 & df$SES_Score>=11, "Lower Middle",
                                     ifelse(df$SES_Score<=10 & df$SES_Score>=5, "Upper Lower",
                                            ifelse(df$SES_Score<5, "Lower", NA)))))

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/SES.csv")
