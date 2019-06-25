#/*
# * Usage: R --no-save --slave --args /Path/to/Data < SST_Scoring_ADBS.R
# * 
# * Created by Bharath Holla - hollabharath@gmail.com
# * ADBS, NIMHANS
# */

#################
rm(list=ls())
library(rowr)
library(data.table)
library(plyr)
library(tools)
cmdargs = commandArgs(trailingOnly=T);
path.in=cmdargs[1]
path.out = dirname(path.in)
setwd(path.in)
files <- list.files(".", pattern =  "\\.csv$", recursive=TRUE, full.names=TRUE)
Testing <- files[ !grepl("Practice", files) ]
df.total = data.frame()
GO_RT_Median = NaN
SSD_Median = NaN
for (currentFile in Testing) {
Sl_No <- print(which(currentFile == Testing));
SubjID <- file_path_sans_ext(basename(file_path_sans_ext(dirname(file_path_sans_ext(dirname(currentFile))))))
sst <- fread(file = currentFile)
GO_SUCCESS       <- sum(sst$`Response Outcome`=='GO_SUCCESS')
GO_WRONG_KEY     <- sum(sst$`Response Outcome`=='GO_WRONG_KEY_RESPONSE')
GO_TOO_LATE      <- sum(sst$`Response Outcome`=='GO_TOO_LATE')
STOP_SUCCESS     <- sum(sst$`Response Outcome`=='STOP_SUCCESS')
STOP_FAILURE     <- sum(sst$`Response Outcome`=='STOP_FAILURE')
STOP_TOO_EARLY   <- sum(sst$`Response Outcome`=='STOP_TOO_EARLY_RESPONSE')
TOTAL_TRIALS     <- GO_SUCCESS+GO_WRONG_KEY+GO_TOO_LATE+STOP_SUCCESS+STOP_FAILURE
GO_Accuracy      <- round(GO_SUCCESS/(GO_SUCCESS+GO_WRONG_KEY+GO_TOO_LATE), digits=4)
Stop_Fail_Ratio  <- round(STOP_FAILURE/(STOP_SUCCESS+STOP_FAILURE), digits=4)
SSD_Mean         <- round(mean(sst$Delay, na.rm = TRUE), digits=4)
SSD_Median       <- median(sst$Delay, na.rm = TRUE)
GO_RT_Mean       <- round(mean(sst$`Relative Response Time`[sst$`Response Outcome`=='GO_SUCCESS']), digits=4)
GO_RT_Median     <- median(sst$`Relative Response Time`[sst$`Response Outcome`=='GO_SUCCESS'])
GO_RT_Variability<- round(sd(sst$`Relative Response Time`[sst$`Response Outcome`=='GO_SUCCESS']), digits=4)
SSRT_Mean        <- round(GO_RT_Mean-SSD_Mean, digits=4)
SSRT_Median      <- round(median(sst$`Relative Response Time`[sst$`Response Outcome`=='GO_SUCCESS']) - median(sst$Delay, na.rm = TRUE), digits=4)
SSRT_Quantile    <- round(quantile(sst$`Relative Response Time`[sst$`Response Outcome`=='GO_SUCCESS'],Stop_Fail_Ratio, names = FALSE)-SSD_Mean, digits=4)
df <-  cbind.fill(Sl_No, SubjID, TOTAL_TRIALS, GO_SUCCESS, GO_WRONG_KEY, GO_TOO_LATE,
                       STOP_SUCCESS,STOP_FAILURE, STOP_TOO_EARLY, GO_Accuracy, Stop_Fail_Ratio, 
                       SSD_Mean, SSD_Median, GO_RT_Mean, GO_RT_Median, GO_RT_Variability, 
                       SSRT_Mean, SSRT_Median, SSRT_Quantile, fill = NaN)
df[df < 0] <- NaN
df[is.na(df)] <- NaN
df.total <- rbind(df.total,df,NULL)
rm(list=ls(pattern="_"))
print(paste("Completed extraction of summary scores from", SubjID))
}
df.total <- setNames(df.total, c("Sl_No", "SubjID", "TOTAL_TRIALS", "GO_SUCCESS", "GO_WRONG_KEY", "GO_TOO_LATE",
         "STOP_SUCCESS","STOP_FAILURE", "STOP_TOO_EARLY", "GO_Accuracy", "Stop_Fail_Ratio", "
         SSD_Mean", "SSD_Median", "GO_RT_Mean", "GO_RT_Median", "GO_RT_Variability", "
         SSRT_Mean", "SSRT_Median", "SSRT_Quantile"))
fileName = paste(path.out,'SST_SummaryScores.csv',sep = '/')
write.csv(df.total,fileName)
### Print Warnings (if any) ####
warnings()
