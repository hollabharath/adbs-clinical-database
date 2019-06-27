df <- read.csv ("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/theminiipipscale_table.csv", header = T)

# Recode the response variables
df$e1 <- as.numeric(ifelse(df$e1=="Yes", 1,ifelse(df$e1=="No",0,NA)))
df$e2 <- as.numeric(ifelse(df$e2=="Yes", 0,ifelse(df$e2=="No",1,NA)))
df$e3 <- as.numeric(ifelse(df$e3=="Yes", 1,ifelse(df$e3=="No",0,NA)))
df$e4 <- as.numeric(ifelse(df$e4=="Yes", 0,ifelse(df$e4=="No",0,NA)))

df$a1 <- as.numeric(ifelse(df$a1=="Yes", 1,ifelse(df$a1=="No",0,NA)))
df$a2 <- as.numeric(ifelse(df$a2=="Yes", 0,ifelse(df$a2=="No",1,NA)))
df$a3 <- as.numeric(ifelse(df$a3=="Yes", 1,ifelse(df$a3=="No",0,NA)))
df$a4 <- as.numeric(ifelse(df$a4=="Yes", 0,ifelse(df$a4=="No",1,NA)))

df$c1 <- as.numeric(ifelse(df$c1=="Yes", 1,ifelse(df$c1=="No",0,NA)))
df$c2 <- as.numeric(ifelse(df$c2=="Yes", 0,ifelse(df$c2=="No",1,NA)))
df$c3 <- as.numeric(ifelse(df$c3=="Yes", 1,ifelse(df$c3=="No",0,NA)))
df$c4 <- as.numeric(ifelse(df$c4=="Yes", 0,ifelse(df$c4=="No",1,NA)))

df$n1 <- as.numeric(ifelse(df$n1=="Yes", 1,ifelse(df$n1=="No",0,NA)))
df$n2 <- as.numeric(ifelse(df$n2=="Yes", 0,ifelse(df$n2=="No",1,NA)))
df$n3 <- as.numeric(ifelse(df$n3=="Yes", 1,ifelse(df$n3=="No",0,NA)))
df$n4 <- as.numeric(ifelse(df$n4=="Yes", 0,ifelse(df$n4=="No",1,NA)))

df$i1 <- as.numeric(ifelse(df$i1=="Yes", 1,ifelse(df$i1=="No",0,NA)))
df$i2 <- as.numeric(ifelse(df$i2=="Yes", 0,ifelse(df$i2=="No",1,NA)))
df$i3 <- as.numeric(ifelse(df$i3=="Yes", 0,ifelse(df$i3=="No",1,NA)))
df$i4 <- as.numeric(ifelse(df$i4=="Yes", 0,ifelse(df$i4=="No",1,NA)))

# Check for subjects with more than 25% missing data/non response for exclusion 
# Also exclude subjects with incorrect visit ID
df_excluded <- df[rowSums(is.na(df)) > (ncol(df)-16)/4 , ]
df_duplicates <- df[nchar(df$assessmentId) !=9, ]
df <- df[rowSums(is.na(df)) < (ncol(df)-16)/4 & nchar(df$assessmentId) ==9, ]
nrow(df_excluded)
nrow(df_duplicates)
nrow(df)

# Visualize missing data
VIM::aggr(df[,5:(ncol(df)-12)])

# Calculate domain scores
df$Openness          <- rowSums(df[,c("i1", "i2", "i3", "i4")], na.rm=TRUE)
df$Conscientiousness <- rowSums(df[,c("c1", "c2", "c3", "c4")], na.rm=TRUE)
df$Extraversion      <- rowSums(df[,c("e1", "e2", "e3", "e4")], na.rm=TRUE)
df$Agreeableness     <- rowSums(df[,c("a1", "a2", "a3", "a4")], na.rm=TRUE)
df$Neuroticism       <- rowSums(df[,c("n1", "n2", "n3", "n4")], na.rm=TRUE)


# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/MINI_IPIP.csv")
