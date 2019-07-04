df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/h_of_i_schizophrenia_table.csv", header =  T, na.strings=c("","NA"))

# Make subset columns and arrange
df <- df[, c("id", "subjectID", "assessmentId", "test_taken_by", 
             "IndexEpisode", "Onset",  "PrecipitatingFactor", "PrecipitatingFactorOther",  "Course", "Remission",
             "Delusion", "PersistentDelusion", "Hallucinations", "PersistentHallucinations", 
             "DisorganisedSpeech", "DisorganisedBehaviour", "NegativeSymptoms", "Mood",  
             "SuicideAttempt", "ECT", "TriggeringFactor", "TriggeringFactorOther", "antipsychotic", "AnyTrial", 
             "deviceid", "date_of_last_update")]

# Rename columns and recode few responses
names(df)[names(df) == 'AnyTrial'] <- 'ClozapineTrial'
names(df)[names(df) == 'antipsychotic'] <- 'BestResponseAP'
df[df=="ATPD"] <- "Predominant psychotic symptoms"
df[df=="Mood with psychosis"] <- "Predominant affective symptoms"
df[,'PrecipitatingFactor'] <- as.factor(gsub(",$","",df[,'PrecipitatingFactor']))
df[,'PrecipitatingFactor'] <- as.factor(gsub(",","_",df[,'PrecipitatingFactor']))
df[,'BestResponseAP'] <- as.factor(gsub(","," and ",df[,'BestResponseAP']))

# Check for subjects with missing data/non response for exclusion 
df_excluded <- df[rowSums(is.na(df[,5:24])) ==20 , ]

# Also check for subjects with incorrect subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | 
                      df$subjectID >170000 | df$subjectID <110000 |
                      duplicated(df$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
df <- df[rowSums(is.na(df[,5:24])) !=20 &
           nchar(df$assessmentId) ==9 & 
           df$subjectID <170000 & df$subjectID >110000 &
           !duplicated(df$assessmentId, fromLast = T), ]

paste("HOPI_SCZ")
paste("Number of subjects with complete missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(df[,-grep("Other$",names(df))], cex.axis=.5)

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/HOPI_SCZ.csv")
