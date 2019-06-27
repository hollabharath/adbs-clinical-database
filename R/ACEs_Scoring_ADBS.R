df <- read.csv("~/Documents/Projects/ADBS/adbs-clinical-database/adversechildhoodexperiencesinternational_table.csv", 
               header = TRUE, stringsAsFactors = FALSE)
# Rename the column headers
names(df) <- c("id", "subjectID", "assessmentId", "test_taken_by", 
               "C1", "C2", "C3", "C4", "C5", "C6", "C7", 
               "M1", "M2", "M3", "M4", "M5", 
               "P1", "P2", "P3", "P4", "P5", 
               "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", 
               "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", 
               "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9 ", "V10", 
               "deviceid", "date_of_last_update")

# Recode the response variables
df[df == "Always"] <- 4
df[df == "Many times"] <- 3
df[df == "Most of the time"] <- 3
df[df == "A few times"] <- 2
df[df == "Sometimes"] <- 2
df[df == "Once"] <- 1
df[df == "Rarely"] <- 1
df[df == "Never"] <- 0
df[df == "Yes"] <- 1
df[df == "No"] <- 0
df[df == "Never (Go to Q.V3)"] <- 0
df[df == "Refused"] <- 0

# Make a new data.frame with necessary columns, exclude the descriptive V2 variable
ID   <- df[, 1:3]
ace1 <- df[,17:38]
ace2 <- df[,40:47]
ace  <- cbind(ID, ace1, ace2)

# Get the data.frame ready for numeric operations
ace[] <- lapply(ace, function(x) as.numeric(as.character(x)))


                
# Check for subjects with more than 20% missing data/non response for exclusion 
ace_excluded <- <- ace[rowSums(is.na(ace)) > ncol(ace)/5 , ]

# Also check for subjects with incorrect subject/visit ID
ace_duplicates <- ace[nchar(ace$assessmentId) !=9 | 
                      ace$subjectID >200000 | 
                      duplicated(ace$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
ace <- ace[rowSums(is.na(ace)) < ncol(ace)/5  & 
           nchar(ace$assessmentId) ==9 & 
           ace$subjectID <200000 & 
           !duplicated(ace$assessmentId, fromLast = T), ]

paste("ACE-IQ")
paste("Number of subjects with >20% missing data:", nrow(ace_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(ace_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(ace)

# ACE sub-domain scores

ace$AP <- ace$A3+ace$A4
ace$AE <- ace$A1+ace$A2
ace$AS <- ace$A5+ace$A6+ace$A7+ace$A8
ace$FAD <- ace$F1
ace$FI  <- ace$F3
ace$FM  <- ace$F2
ace$FV  <- ace$F6+ace$F7+ace$F8
ace$FP  <- ace$F4+ace$F5
ace$NE  <- ace$P1+ace$P2
ace$NP  <- ace$P3+ace$P4+ace$P5
ace$BUL <- ace$V1
ace$ComV<- ace$V4+ace$V5+ace$V6
ace$ColV<- ace$V7+ace$V8+ace$V9+ace$V10



# ACE Binary Score Calculation as per WHO scoring guidelines
ace$AP_B  <- ifelse(ace$A3>0 | ace$A4>0 , 1, 0)
ace$AE_B  <- ifelse(ace$A1>0  | ace$A2>0  , 1, 0)
ace$AS_B  <- ifelse(ace$A5>0 | ace$A6>0 | ace$A7>0 |ace$A8>0, 1, 0)
ace$FAD_B <- ifelse(ace$F1==1, 1, 0)
ace$FI_B  <- ifelse(ace$F3==1, 1, 0)
ace$FM_B  <- ifelse(ace$F2==1, 1, 0)
ace$FV_B  <- ifelse(ace$F6>0  | ace$F7>0  | ace$F8>0 , 1, 0)
ace$FP_B  <- ifelse(ace$F4==1 | ace$F5==1, 1, 0)
ace$NE_B  <- ifelse(ace$P1>0  | ace$P2>0 , 0, 1)
ace$NP_B  <- ifelse(ace$P3>0 | ace$P4>0  | ace$P5>0 , 1, 0)
ace$BUL_B <- ifelse(ace$V1>0 , 1, 0)
ace$ComV_B<- ifelse(ace$V4>0  | ace$V5>0  | ace$V6>0 , 1, 0)
ace$ColV_B<- ifelse(ace$V7>0 | ace$V8>0 | ace$V9>0 | ace$V10>0, 1, 0)


# ACE Frequency Score Calculation as per WHO scoring guidelines
ace$AP_F  <- ifelse(ace$A3==3 | ace$A4==3 , 1, 0)
ace$AE_F  <- ifelse(ace$A1==3 | ace$A2==3 , 1, 0)
ace$AS_F  <- ifelse(ace$A5>0 | ace$A6>0 | ace$A7>0 |ace$A8>0, 1, 0)
ace$FAD_F <- ifelse(ace$F1==1, 1, 0)
ace$FI_F  <- ifelse(ace$F3==1, 1, 0)
ace$FM_F  <- ifelse(ace$F2==1, 1, 0)
ace$FV_F  <- ifelse(ace$F6==3 | ace$F7>=2 | ace$F8>=2, 1, 0)
ace$FP_F  <- ifelse(ace$F4==1 | ace$F5==1, 1, 0)
ace$NE_F  <- ifelse(ace$P1<=1 | ace$P2<=1, 1, 0)
ace$NP_F  <- ifelse(ace$P3==3 | ace$P4==3 | ace$P5==3, 1, 0)
ace$BUL_F <- ifelse(ace$V1==3, 1, 0)
ace$ComV_F<- ifelse(ace$V4==3 | ace$V5==3 | ace$V6==3, 1, 0)
ace$ColV_F<- ifelse(ace$V7>0 | ace$V8>0 | ace$V9>0 | ace$V10>0, 1, 0)



# Summate Binary and Frequency Scores
ace$Binary.Score   <- rowSums(ace[, c("AP_B" , "AE_B" , "AS_B" , "FAD_B" , "FI_B" , 
                                    "FM_B" , "FV_B" , "FP_B" , "NE_B" , "NP_B" , 
                                    "BUL_B" , "ComV_B" , "ColV_B")], na.rm=TRUE)

ace$Frequency.Score <- rowSums(ace[, c("AP_F" , "AE_F" , "AS_F" , "FAD_F" , "FI_F" , 
                                       "FM_F" , "FV_F" , "FP_F" , "NE_F" , "NP_F" , 
                                       "BUL_F" , "ComV_F" , "ColV_F")], na.rm=TRUE)
  

# Compute Total and Domain Scores

ace$Total.Score    <- rowSums(ace[, c("AP" , "AE" , "AS" , "FAD" , "FI" , 
                                   "FM" , "FV" , "FP" , "NE" , "NP" , 
                                   "BUL" , "ComV" , "ColV")], na.rm=TRUE)

ace$Abuse.Score    <- rowSums(ace[, c("AP" , "AE" , "AS")], na.rm=TRUE)

ace$Neglect.Score  <- rowSums(ace[, c("NE" , "NP")], na.rm=TRUE)

ace$Household.Challenges.Score <- rowSums(ace[, c("FAD", "FI", "FM", "FV", "FP")], na.rm=TRUE)

ace$Community.Challenges.Score <- rowSums(ace[, c("BUL" , "ComV" , "ColV")], na.rm=TRUE)

write.csv(ace, "~/Documents/Projects/ADBS/adbs-clinical-database/aces_summary_scores.csv")
