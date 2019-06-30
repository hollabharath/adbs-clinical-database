df <-read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/globalassessmentoffunctioningscale_table.csv", header= T)

# Rename the column headers
names(df) <- c("id", "subjectID", "assessmentId", "test_taken_by", "dummy",
               "deviceid", "date_of_last_update", "GAF")

# Check for subjects with missing data/non response for exclusion 
df_excluded <- df[is.na(df$GAF), ]

# Also check for subjects with incorrect subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | 
                      df$subjectID >200000 | 
                      duplicated(df$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
df <- df[!is.na(df$GAF) & 
           nchar(df$assessmentId) ==9 & 
           df$subjectID <200000 & 
           !duplicated(df$assessmentId, fromLast = T), ]

# Visualize missing data
VIM::aggr(df)

paste("GAF")
paste("Number of subjects with complete missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/GAF.csv")
