df <- read.csv ("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/young_mania_table.csv", header = T)

# Check for subjects with more than 25% missing data/non response for exclusion 
df_excluded <- df[rowSums(is.na(df)) > (ncol(df)-8)/4 , ]

# Also check for subjects with incorrect subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | 
                      df$subjectID >200000 | 
                      duplicated(df$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
df <- df[rowSums(is.na(df)) < (ncol(df)-8)/4 & 
           nchar(df$assessmentId) ==9 & 
           df$subjectID <200000 & 
           !duplicated(df$assessmentId, fromLast = T), ]

paste("YMRS")
paste("Number of subjects with >25% missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(df[,5:(ncol(df)-4)])

# Calculate total YMRS score
df$YMRS.score <- rowSums(df[,5:(ncol(df)-4)], na.rm = TRUE)

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/YMRS.csv")
