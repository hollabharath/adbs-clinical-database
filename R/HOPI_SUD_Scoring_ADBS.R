df <- read.csv ("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/h_of_i_addtiction_table.csv", header = T, na.strings=c("","NA"))

names(df) <-   c("id", "subjectID", "assessmentId", "test_taken_by", 
                "seizure", "WithdrawalSeizure", "DT", "Medical", "Social",
                "Tobacco_form", "FTND1_smoke",  "FTND2_smoke",  "FTND3_smoke",  
                "FTND4_smoke",  "FTND5_smoke",  "FTND6_smoke",
                "FTND1_smokeless",  "FTND2_smokeless",  "FTND3_smokeless",  
                "FTND4_smokeless",  "FTND5_smokeless",  "FTND6_smokeless",
                "FTND_smokeless_total", "FTND_smoke_total" ,
                "age_at_first_use", "age_at_regular_use", "age_at_first_withdrwal_seizure",
                "total_seizures",  "age_at_first_DT" , "total_DT_episodes", "describe_medical_complications", 
                "describe_social_complications", "deviceid", "date_of_last_update")

# Recode 
df$Tobacco_form <- as.factor(ifelse(df$Tobacco_form=="Chew ,", "Chew",
                                    ifelse(df$Tobacco_form=="Chew ,Smoke ,", "Chew_Smoke",
                                           ifelse(df$Tobacco_form=="Smoke ,", "Smoke",
                                                  ifelse(df$Tobacco_form=="No", "No",NA)))))
df[df == "Total"] <- NA

# Also exclude subjects with incorrect/duplicate subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | df$subjectID >200000 | duplicated(df$assessmentId), ]
df <- df[!duplicated(df$assessmentId) & nchar(df$assessmentId) ==9 & df$subjectID <200000, ]

paste("HOPI_SUD")
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/HOPI_SUD.csv")
