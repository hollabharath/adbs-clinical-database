df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/cgitable.csv", header = T)

names(df) <- c("id", "subjectID", "assessmentId", "test_taken_by",
               "cgi_s", "cgi_i", "cgi_e", 
               "deviceid", "date_of_last_update", "Stotal")

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


paste("CGI")
paste("Number of subjects with complete missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(df[,5:7])

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/CGI.csv")
