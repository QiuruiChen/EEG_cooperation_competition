rm(list = ls())
setwd('D:/work/eeg/Final/last15s')
library(R.matlab)
library(ggplot2)
library(reshape)
library(dplyr)

# # # preprocessing the dataframe
# # ispc_compet<- readMat('ispc_compet.mat')
# # ispc_compet <- as.data.frame(ispc_compet[["ispc.compet"]])
# # ispc_compet$ID <- seq.int(nrow(ispc_compet))
# # ispc_compet <- melt(ispc_compet, id.vars=c('ID'),var='ispc')
# # 
# # ispc_compet$ID <- factor(ispc_compet$ID)
# # 
# # saveRDS(ispc_compet, file="ispc_compet.Rda")
# # ispc_compet <- readRDS(file="ispc_compet.Rda")
# # 
# # # cop
# # ispc_cop<- readMat('ispc_cop.mat')
# # ispc_cop <- as.data.frame(ispc_cop[["ispc.cop"]])
# # ispc_cop$ID <- seq.int(nrow(ispc_cop))
# # ispc_cop <- melt(ispc_cop, id.vars=c('ID'),var='ispc')
# # ispc_cop$ID <- factor(ispc_cop$ID)
# # 
# # saveRDS(ispc_cop, file="ispc_cop.Rda")
# 
# # plot
# ispc_cop <- readRDS(file="ispc_cop.Rda")
# ispc_compet <- readRDS(file="ispc_compet.Rda")
# ispc_cop$cond <- factor('cop');
# ispc_compet$cond <- factor('compet')
# ispc_all <- rbind(ispc_cop,ispc_compet)
# ispc_all<-ispc_all[!(ispc_all$value ==1),]
# 
# p<- ggplot(ispc_all,aes(ID,value,fill=cond)) +
#   geom_boxplot() +
#   ggtitle('Boxpot of ispc-based INS over frequency')+
#   xlab('Frequency(Hz)') + ylab('ISPC value')+
#   theme(text = element_text(size=20),
#         axis.text.x = element_text(angle=90, hjust=1))
# ggsave("INS_over_freq.png", plot = p)

## plot over time
# preprocessing the dataframe
# ispc_compet_time<- readMat('ispc_compet_time.mat')
# ispc_compet_time <- as.data.frame(ispc_compet_time[["ispc.compet.time"]])
# ispc_compet_time$ID <- seq.int(nrow(ispc_compet_time))
# ispc_compet_time <- melt(ispc_compet_time, id.vars=c('ID'),var='ispc')
# 
# ispc_compet_time$ID <- factor(ispc_compet_time$ID)
# 
# saveRDS(ispc_compet_time, file="ispc_compet_time.Rda")
# ispc_compet_time <- readRDS(file="ispc_compet_time.Rda")
# 
# # cop
# ispc_cop_time<- readMat('ispc_cop_time.mat')
# ispc_cop_time <- as.data.frame(ispc_cop_time[["ispc.cop.time"]])
# ispc_cop_time$ID <- seq.int(nrow(ispc_cop_time))
# ispc_cop_time <- melt(ispc_cop_time, id.vars=c('ID'),var='ispc')
# ispc_cop_time$ID <- factor(ispc_cop_time$ID)
# 
# saveRDS(ispc_cop_time, file="ispc_cop_time.Rda")

# plot
ispc_cop <- readRDS(file="ispc_cop_time_time.Rda")
ispc_compet <- readRDS(file="ispc_compet_time.Rda")
ispc_cop$cond <- factor('cop');
ispc_compet$cond <- factor('compet')
ispc_all <- rbind(ispc_cop,ispc_compet)
ispc_all<-ispc_all[!(ispc_all$value ==1),]

p<- ggplot(ispc_all,aes(ID,value,fill=cond)) +
  geom_boxplot() +
  ggtitle('Boxpot of ispc-based INS over time')+
  xlab('Time(s)') + ylab('ISPC value')+
  scale_x_discrete(breaks=c(4,8,12,16,20,24,28,32,36,40,44,48,52,56,60),
                   labels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"))
  theme(text = element_text(size=20),
        axis.text.x = element_text(angle=90, hjust=1))
ggsave("INS_over_time.png", plot = p)



