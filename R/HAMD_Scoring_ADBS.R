df <- read.csv("/Users/hollabharath/Documents/Projects/ADBS/DATA_QC/Scripts/hamiltonratingscalefordepression_table.csv", header = T)

# Check for subjects with more than 25% missing data/non response for exclusion 
# Also exclude subjects with incorrect visit ID
df_excluded <- df[rowSums(is.na(df)) > (ncol(df)-6)/4 , ]
df_duplicates <- df[nchar(df$assessmentId) !=9 | df$subjectID >200000, ]
df <- df[rowSums(is.na(df)) < (ncol(df)-6)/4 & nchar(df$assessmentId) ==9 & df$subjectID <200000, ]

paste("HAMD")
paste("Number of subjects with >25% missing data:", nrow(df_excluded))
paste("Number of subjects with incorrect subject/visit ID:", nrow(df_duplicates))
paste("Number of subjects with usable data:", nrow(df))

# Visualize missing data
VIM::aggr(df[,5:(ncol(df)-3)])

# Calculate total HAMA score
df$HAMD.score <- rowSums(df[,5:(ncol(df)-3)], na.rm = TRUE)

# Save to file
write.csv(df, "/Users/hollabharath/Documents/Projects/ADBS/HAMD.csv")
