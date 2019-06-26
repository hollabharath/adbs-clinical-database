df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/adulttemperamentquestionnaire_table.csv", header = T)

# Rename the column headers
names(df) <- c("id", "subjectID", "assessmentId", "test_taken_by", 
               "atq1", "atq2", "atq3", "atq4", "atq5", "atq6", "atq7", "atq8", "atq9", "atq10", 
               "atq11", "atq12", "atq13", "atq14", "atq15", "atq16", "atq17", "atq18", "atq19", 
               "atq20", "atq21", "atq22", "atq23", "atq24", "atq25", "atq26", "atq27", "atq28", 
               "atq29", "atq30", "atq31", "atq32", "atq33", "atq34", "atq35", "atq36", "atq37", 
               "atq38", "atq39", "atq40", "atq41", "atq42", "atq43", "atq44", "atq45", "atq46", 
               "atq47", "atq48", "atq49", "atq50", "atq51", "atq52", "atq53", "atq54", "atq55", 
               "atq56", "atq57", "atq58", "atq59", "atq60", "atq61", "atq62", "atq63", "atq64", 
               "atq65", "atq66", "atq67", "atq68", "atq69", "atq70", "atq71", "atq72", "atq73", 
               "atq74", "atq75", "atq76", "atq77","total_score", 
               "deviceid", "date_of_last_update")

# Recode the response variables
df[df == 0] <- NA
df[df == "X"] <- NA

# Get the data.frame ready for numeric operations
df <- df[,1:(ncol(df)-3)]
df[] <- lapply(df, function(x) as.numeric(as.character(x)))

# Check for subjects with more than 25% missing data/non response for exclusion 
# Also exclude subjects with incorrect visit ID
df_excluded <- df[rowSums(is.na(df)) > (ncol(df)-4)/4 , ]
df_duplicates <- df[nchar(df$assessmentId) !=9, ]
df <- df[rowSums(is.na(df)) < (ncol(df)-4)/4 & nchar(df$assessmentId) ==9, ]
nrow(df_excluded)
nrow(df_duplicates)
nrow(df)

# Visualize missing data 
VIM::aggr(df[,5:ncol(df)])

# Impute using mean of entire sample (Optional)
df[] <- lapply(df, function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))

# reverse code items
df$atq68r <- 8-df$atq68
df$atq75r <- 8-df$atq75
df$atq6r <- 8-df$atq6
df$atq38r <- 8-df$atq38
df$atq58r <- 8-df$atq58
df$atq9r <- 8-df$atq9
df$atq20r <- 8-df$atq20
df$atq34r <- 8-df$atq34
df$atq2r <- 8-df$atq2
df$atq8r <- 8-df$atq8
df$atq72r <- 8-df$atq72
df$atq5r <- 8-df$atq5
df$atq29r <- 8-df$atq29
df$atq40r <- 8-df$atq40
df$atq50r <- 8-df$atq50
df$atq53r <- 8-df$atq53
df$atq60r <- 8-df$atq60
df$atq63r <- 8-df$atq63
df$atq14r <- 8-df$atq14
df$atq46r <- 8-df$atq46
df$atq7r <- 8-df$atq7
df$atq44r <- 8-df$atq44
df$atq77r <- 8-df$atq77
df$atq16r <- 8-df$atq16
df$atq70r <- 8-df$atq70
df$atq10r <- 8-df$atq10
df$atq33r <- 8-df$atq33
df$atq71r <- 8-df$atq71
df$atq66r <- 8-df$atq66


# Compute sub-component scores

df$ATQ_NA_fear <- rowMeans(df[,c("atq1", "atq12", "atq22", "atq51", "atq61", "atq68r", "atq75r")], na.rm=TRUE)
df$ATQ_NA_frustration <- rowMeans(df[,c("atq6r", "atq17", "atq31", "atq38r", "atq48", "atq58r")], na.rm=TRUE)
df$ATQ_NA_sadness <- rowMeans(df[,c("atq9r", "atq20r", "atq25", "atq34r", "atq45", "atq56", "atq65")], na.rm=TRUE)
df$ATQ_NA_discomfort <- rowMeans(df[,c("atq4", "atq32", "atq36", "atq42", "atq54", "atq59")], na.rm=TRUE)
df$ATQ_EC_activation <- rowMeans(df[,c("atq2r", "atq8r", "atq15", "atq27", "atq47", "atq55", "atq72r")], na.rm=TRUE)
df$ATQ_EC_attention <- rowMeans(df[,c("atq5r", "atq29r", "atq35", "atq40r", "atq50r")], na.rm=TRUE)
df$ATQ_EC_inhibitory <- rowMeans(df[,c("atq11", "atq26", "atq43", "atq53r", "atq60r", "atq63r", "atq76")], na.rm=TRUE)
df$ATQ_EV_sociability <- rowMeans(df[,c("atq14r", "atq19", "atq37", "atq46r", "atq67")], na.rm=TRUE)
df$ATQ_EV_highintensitypleasure <- rowMeans(df[,c("atq7r", "atq23", "atq30", "atq44r", "atq64", "atq73", "atq77r")], na.rm=TRUE)
df$ATQ_EV_positiveaffect <- rowMeans(df[,c("atq3", "atq16r", "atq28", "atq49", "atq70r")], na.rm=TRUE)
df$ATQ_SE_neutralperceptual<- rowMeans(df[,c("atq10r", "atq21", "atq33r", "atq52", "atq71r")], na.rm=TRUE)
df$ATQ_SE_affectiveperceptual <- rowMeans(df[,c("atq13", "atq18", "atq57", "atq66r", "atq69")], na.rm=TRUE)
df$ATQ_SE_associative <- rowMeans(df[,c("atq24", "atq39", "atq41", "atq62", "atq74")], na.rm=TRUE)

# Compute component scores
df$ATQ_NEGATIVE_AFFECT=df$ATQ_NA_fear + df$ATQ_NA_frustration + df$ATQ_NA_sadness + df$ATQ_NA_discomfort
df$ATQ_EFFORTFUL_CONTROL=df$ATQ_EC_activation + df$ATQ_EC_attention + df$ATQ_EC_inhibitory
df$ATQ_EXTRAVERSION=df$ATQ_EV_sociability + df$ATQ_EV_highintensitypleasure + df$ATQ_EV_positiveaffect
df$ATQ_SENSITIVITY=df$ATQ_SE_neutralperceptual + df$ATQ_SE_affectiveperceptual + df$ATQ_SE_associative 

# Plot distribution of major components
par(mfrow = c(2,2))
plot(density(df$ATQ_NEGATIVE_AFFECT, na.rm = T))
plot(density(df$ATQ_EFFORTFUL_CONTROL, na.rm = T))
plot(density(df$ATQ_EXTRAVERSION, na.rm = T))
plot(density(df$ATQ_SENSITIVITY, na.rm = T))

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/ATQ.csv")
