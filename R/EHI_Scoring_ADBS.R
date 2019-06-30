df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/edinburghhandednessinventory_table.csv", header = T)

# Recode 
df$WritingL <- ifelse(is.na(df$WritingR),df$WritingL,ifelse(df$WritingR==2,0,ifelse(df$WritingR==1,1,ifelse(df$WritingR==0,2,NA))))
df$DrawingL <- ifelse(is.na(df$DrawingR),df$DrawingL,ifelse(df$DrawingR==2,0,ifelse(df$DrawingR==1,1,ifelse(df$DrawingR==0,2,NA))))
df$ThrowingL <- ifelse(is.na(df$ThrowingR),df$ThrowingL,ifelse(df$ThrowingR==2,0,ifelse(df$ThrowingR==1,1,ifelse(df$ThrowingR==0,2,NA))))
df$ScissorsL <- ifelse(is.na(df$ScissorsR),df$ScissorsL,ifelse(df$ScissorsR==2,0,ifelse(df$ScissorsR==1,1,ifelse(df$ScissorsR==0,2,NA))))
df$ToothbrushL <- ifelse(is.na(df$ToothbrushR),df$ToothbrushL,ifelse(df$ToothbrushR==2,0,ifelse(df$ToothbrushR==1,1,ifelse(df$ToothbrushR==0,2,NA))))
df$KnifeL <- ifelse(is.na(df$KnifeR),df$KnifeL,ifelse(df$KnifeR==2,0,ifelse(df$KnifeR==1,1,ifelse(df$KnifeR==0,2,NA))))
df$SpoonL <- ifelse(is.na(df$SpoonR),df$SpoonL,ifelse(df$SpoonR==2,0,ifelse(df$SpoonR==1,1,ifelse(df$SpoonR==0,2,NA))))
df$BroomL <- ifelse(is.na(df$BroomR),df$BroomL,ifelse(df$BroomR==2,0,ifelse(df$BroomR==1,1,ifelse(df$BroomR==0,2,NA))))
df$StrikingL <- ifelse(is.na(df$StrikingR),df$StrikingL,ifelse(df$StrikingR==2,0,ifelse(df$StrikingR==1,1,ifelse(df$StrikingR==0,2,NA))))
df$OpeningL <- ifelse(is.na(df$OpeningR),df$OpeningL,ifelse(df$OpeningR==2,0,ifelse(df$OpeningR==1,1,ifelse(df$OpeningR==0,2,NA))))
df$WhichfootL <- ifelse(is.na(df$WhichfootR),df$WhichfootL,ifelse(df$WhichfootR==2,0,ifelse(df$WhichfootR==1,1,ifelse(df$WhichfootR==0,2,NA))))
df$WhicheyeL <- ifelse(is.na(df$WhicheyeR),df$WhicheyeL,ifelse(df$WhicheyeR==2,0,ifelse(df$WhicheyeR==1,1,ifelse(df$WhicheyeR==0,2,NA))))


df$WritingS <- rowSums(df[,c("WritingL", "WritingR")], na.rm = T)
df$DrawingS <- rowSums(df[,c("DrawingL", "DrawingR")], na.rm = T)
df$ThrowingS <- rowSums(df[,c("ThrowingL", "ThrowingR")], na.rm = T)
df$ScissorsS <- rowSums(df[,c("ScissorsL", "ScissorsR")], na.rm = T)
df$ToothbrushS <- rowSums(df[,c("ToothbrushL", "ToothbrushR")], na.rm = T)
df$KnifeS <- rowSums(df[,c("KnifeL", "KnifeR")], na.rm = T)
df$SpoonS <- rowSums(df[,c("SpoonL", "SpoonR")], na.rm = T)
df$BroomS <- rowSums(df[,c("BroomL", "BroomR")], na.rm = T)
df$StrikingS <- rowSums(df[,c("StrikingL", "StrikingR")], na.rm = T)
df$OpeningS <- rowSums(df[,c("OpeningL", "OpeningR")], na.rm = T)
df$WhichfootS <- rowSums(df[,c("WhichfootL", "WhichfootR")], na.rm = T)
df$WhicheyeS <- rowSums(df[,c("WhicheyeL", "WhicheyeR")],na.rm = T)

# Check for subjects with missing data/non response for exclusion 
df_excluded <- df[rowSums(df[,grep("S$",names(df))]) ==0 , ]
head(df_excluded)

# Also check for subjects with incorrect subject/visit ID
df_duplicates <- df[nchar(df$assessmentId) !=9 | 
                      df$subjectID >200000 | 
                      duplicated(df$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
df <- df[rowSums(df[,grep("S$",names(df))]) !=0  & 
           nchar(df$assessmentId) ==9 & 
           df$subjectID <200000 & 
           !duplicated(df$assessmentId, fromLast = T), ]

# Visualize missing data
df[,grep("S$",names(df))][df[,grep("S$",names(df))]==0] <- NA
VIM::aggr(df[,grep("S$",names(df))])

paste("EHI")
paste("Number of subjects with complete missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Calculate EHI Laterality Quotient and Handedness Category
df$RH        <- rowSums(df[, c("WritingR", "DrawingR", "ThrowingR", "ScissorsR", "ToothbrushR", "KnifeR", "SpoonR", "BroomR", "StrikingR", "OpeningR")], na.rm = T)
df$LH        <- rowSums(df[, c("WritingL", "DrawingL", "ThrowingL", "ScissorsL", "ToothbrushL", "KnifeL", "SpoonL", "BroomL", "StrikingL", "OpeningL")], na.rm = T)
df$EHI_LQ    <- (df$RH-df$LH)*100/(df$RH+df$LH)
df$EHI_Cat <- ifelse(df$EHI_LQ > 40, "Right Handed", ifelse(df$EHI_LQ < -40, "Left Handed", ifelse(df$EHI_LQ >= -40 & df$EHI_LQ <= 40, "Ambidextrous", NA)))

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/EHI.csv")
