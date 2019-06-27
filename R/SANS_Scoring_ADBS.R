df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/sans_table.csv", header = T)
names(df) <-   c("id", "subjectID", "assessmentId", "test_taken_by","STUDY", "GROUP_1", "PATIENT2", 
                 "RATING", "CARD2", "Sex", "Birthday", "Date_111", "First", "Second", "Diagnostic", 
                 "Age", "Course", "Duration", "Medication", "Current", "Educational", "DATE_222", 
                 "INTERVIEWER", "HOSPITAL", "PATIENT", "CARD", 
                 "AF1", "AF2", "AF3", "AF4", "AF5", "AF6", "AF7", "AFG", 
                 "AL1", "AL2", "AL3", "AL4", "ALG", "AV1", "AV2", "AV3", "AVG", 
                 "AN1", "AN2", "AN3", "AN4", "ANG", "AT1", "AT2", "ATG", 
                 "total", "affective_total", "alogia_total", 
                 "avolition_total", "anhedonia_total", "attention_total", 
                 "deviceid", "date_of_last_update")

df <- df[,c("id", "subjectID", "assessmentId", "test_taken_by",
            "AF1", "AF2", "AF3", "AF4", "AF5", "AF6", "AF7", "AFG", 
            "AL1", "AL2", "AL3", "AL4", "ALG", 
            "AV1", "AV2", "AV3", "AVG", 
            "AN1", "AN2", "AN3", "AN4", "ANG", 
            "AT1", "AT2", "ATG", 
            "total", "affective_total", "alogia_total", 
            "avolition_total", "anhedonia_total", "attention_total", 
            "deviceid", "date_of_last_update")]

# Check for subjects with more than 25% missing data/non response for exclusion 
df_excluded <- df[rowSums(is.na(df)) > (ncol(df)-6)/4 , ]

# Also check for subjects with incorrect subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | 
                      df$subjectID >200000 | 
                      duplicated(df$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
df <- df[rowSums(is.na(df)) < (ncol(df)-6)/4 & 
           nchar(df$assessmentId) ==9 & 
           df$subjectID <200000 & 
           !duplicated(df$assessmentId, fromLast = T), ]


paste("SANS")
paste("Number of subjects with >25% missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(df[,5:(ncol(df)-2)])

# Compute sub-domain scores
df$SANS_AffectiveFlattening <- rowSums(df[,c("AF1", "AF2", "AF3", "AF4", "AF5", "AF6", "AF7", "AFG")], na.rm=TRUE)
df$SANS_Alogia <- rowSums(df[,c("AL1", "AL2", "AL3", "AL4", "ALG")], na.rm=TRUE)
df$SANS_Avolition <- rowSums(df[,c("AV1", "AV2", "AV3", "AVG")], na.rm=TRUE)
df$SANS_Anhedonia <- rowSums(df[,c("AN1", "AN2", "AN3", "AN4", "ANG")], na.rm=TRUE)
df$SANS_Attention <- rowSums(df[,c("AT1", "AT2", "ATG")], na.rm=TRUE)
df$SANS_total <- rowSums(df[,c("SANS_AffectiveFlattening", "SANS_Alogia", "SANS_Avolition", "SANS_Anhedonia","SANS_Attention")], na.rm=TRUE)

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/SANS.csv")
