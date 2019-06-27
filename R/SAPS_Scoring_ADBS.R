df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/saps_table.csv", header = T)
colnames(df)
names(df) <- c("id", "subjectID", "assessmentId", "test_taken_by", "STUDY1", "GROUP_2", "PATIENT3", "RATING1", "CARD3", 
               "Sex1", "Birthday1", "Date_1", "First1", "Second1", "Diagnostic1", "Age1", "Course1", "Duration1", 
               "Medication1", "Current1", "Educational1", "DATE_2", "INTERVIEWER1", "HOSPITAL1", "PATIENT1", "CARD1", 
               "HAL1", "HAL2", "HAL3", "HAL4", "HAL5", "HAL6", "HALG", 
               "DEL1", "DEL2", "DEL3", "DEL4", "DEL5", "DEL6", "DEL7", "DEL8", "DEL9", "DEL10", "DEL11", "DEL12", "DELG", 
               "BIZ1", "BIZ2", "BIZ3", "BIZ4", "BIZG", 
               "FTD1", "FTD2", "FTD3", "FTD4", "FTD5", "FTD6", "FTD7", "FTD8", "FTDG", 
               "total", "hallucinations_total", "delusions_total", "bizzarre_total", "positive_total", 
               "deviceid", "date_of_last_update")

df <- df[,c("id", "subjectID", "assessmentId", "test_taken_by",
            "HAL1", "HAL2", "HAL3", "HAL4", "HAL5", "HAL6", "HALG", 
            "DEL1", "DEL2", "DEL3", "DEL4", "DEL5", "DEL6", "DEL7", "DEL8", "DEL9", "DEL10", "DEL11", "DEL12", "DELG", 
            "BIZ1", "BIZ2", "BIZ3", "BIZ4", "BIZG", 
            "FTD1", "FTD2", "FTD3", "FTD4", "FTD5", "FTD6", "FTD7", "FTD8", "FTDG", 
            "total", "hallucinations_total", "delusions_total", "bizzarre_total", "positive_total", 
            "deviceid", "date_of_last_update")]

# Check for subjects with more than 25% missing data/non response for exclusion 
df_excluded <- df[rowSums(is.na(df)) > (ncol(df)-11)/4 , ]

# Also check for subjects with incorrect subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | 
                      df$subjectID >200000 | 
                      duplicated(df$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
df <- df[rowSums(is.na(df)) < (ncol(df)-11)/4 & 
           nchar(df$assessmentId) ==9 & 
           df$subjectID <200000 & 
           !duplicated(df$assessmentId, fromLast = T), ]


paste("SAPS")
paste("Number of subjects with >25% missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(df[,5:(ncol(df)-2)])

# Compute sub-domain scores
df$SAPS_Hallucination <- rowSums(df[,c("HAL1", "HAL2", "HAL3", "HAL4", "HAL5", "HAL6", "HALG")], na.rm=TRUE)
df$SAPS_Delusion <- rowSums(df[,c("DEL1", "DEL2", "DEL3", "DEL4", "DEL5", "DEL6", "DEL7", "DEL8", "DEL9", "DEL10", "DEL11", "DEL12", "DELG")], na.rm=TRUE)
df$SAPS_Bizzare <- rowSums(df[,c("BIZ1", "BIZ2", "BIZ3", "BIZ4", "BIZG")], na.rm=TRUE)
df$SAPS_FTD <- rowSums(df[,c("FTD1", "FTD2", "FTD3", "FTD4", "FTD5", "FTD6", "FTD7", "FTD8", "FTDG")], na.rm=TRUE)
df$SAPS_total <- rowSums(df[,c("SAPS_Hallucination", "SAPS_Delusion", "SAPS_Bizzare", "SAPS_FTD")], na.rm=TRUE)

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/SAPS.csv")
