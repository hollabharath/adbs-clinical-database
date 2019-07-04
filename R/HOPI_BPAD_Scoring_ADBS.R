df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/h_of_i_bipolar_disorder_table.csv", header = TRUE, na.strings=c("","NA"))

# Rename columns and recode few responses
names(df) <- c("id", "subjectID", "assessmentId", "test_taken_by", 
             "IndexEpisode", "OnsetDate",  "PrecipitatingFactor", "OnsetType",
             "PostPartumOnset", "Seasonality", "PsychoticCourse", "RapidCycling", 
             "SuicidalAttempt", "InterEpisodeRemission" , "PartialRemissionSymptoms",
             "MaxInterEpiDuration", "MaxInterEpiYear", "BPAD_DOI_m", "ans12a",
             "DrugCompliance", "RecievedECT", "PsychoticSxEpisodes", "RapidCycling_when",
             "SuicidalAttempt_when", "PsychoticCourse_which", "PercentTimeSx",
             "AAO_y", "FirstMania_Age", "FirstDepression_Age",
             "TotalEpisodes", "HypomaniaEpisodes", "ManiaEpisodes", "DepressiveEpisodes",
             "MixedEpisodes", "TotalEpisodeDuration_m", "TotalManiaDuration_m", 
             "TotalDepressionDuration_m", "NA", "lithium_level",
             "Total_IP_care", "Total_ECT_dep", "Total_ECT_mania", 
             "response_LiAp", "response_ValAp", "response_1Ap", "response_2Ap" , "response_Li",
             "response_Val", "response_LiVal", "response_AD_MS_AP", "response_others", "response_desc_others",
             "NA","NA","NA","NA", "deviceid", "date_of_last_update")
df[,'PrecipitatingFactor'] <- as.factor(gsub(",$","",df[,'PrecipitatingFactor']))
df[,'PrecipitatingFactor'] <- as.factor(gsub(",","_",df[,'PrecipitatingFactor']))
df[,'RapidCycling_when'] <- as.factor(gsub("â€“","and",df[,'RapidCycling_when']))
df[,'OnsetDate'] <- as.factor(gsub(" ","",df[,'OnsetDate']))
df[,'OnsetDate'] <- paste(df$OnsetDate,"-01" ,sep = "")
df$OnsetDate <- as.Date(df$OnsetDate, "%Y-%m-%d")
df$BestDrug <- as.factor(paste(df$response_LiAp,"-",df$response_ValAp,"-",df$response_1Ap, "-",
                               df$response_2Ap,"-", df$response_Li,"-",df$response_Val, "-",
                               df$response_LiVal,"-", df$response_AD_MS_AP,"-", df$response_others))
df[,'BestDrug'] <- as.factor(gsub("NA","",df[,'BestDrug']))
df[,'BestDrug'] <- as.factor(gsub(" - ","",df[,'BestDrug']))
df[,'BestDrug'] <- as.factor(gsub(" ","",df[,'BestDrug']))
df <- df[,-grep("NA",names(df))]
df <- df[,-grep("response",names(df))]
# Check for subjects with missing data/non response for exclusion 
df_excluded <- df[rowSums(is.na(df[,5:41])) ==37 , ]

# Also check for subjects with incorrect subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | 
                      df$subjectID >170000 | df$subjectID <110000 |
                      duplicated(df$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
df <- df[rowSums(is.na(df[,5:41])) !=37 &
           nchar(df$assessmentId) ==9 & 
           df$subjectID <170000 & df$subjectID >110000 &
           !duplicated(df$assessmentId, fromLast = T), ]

paste("HOPI_BPAD")
paste("Number of subjects with complete missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(df[,5:41], cex.axis=.5)

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/HOPI_BPAD.csv")
