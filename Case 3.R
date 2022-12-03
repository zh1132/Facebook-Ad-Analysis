#===============================================================================
#GBA424_case3
#Code by Zhikai Hu
#===============================================================================
library(jtools)
rm(list=ls())
df <- read.csv('Data edited.csv')

#General Analysis
df_1 <- subset(df, date == '3/26/2013')
df_2 <- subset(df, date == '4/17/2013')

reg1 <- lm(Score ~ factor(adType)+factor(category)+factor(placement)+factor(keywords)+
               factor(body)+ageMean+factor(category)*ageMean, data=df_1)
reg2 <- lm(Score ~ factor(adType)+factor(category)+factor(placement)+factor(keywords)+
               factor(body)+ageMean+factor(category)*ageMean, data=df_2)

#eCom Analysis
df_1_ecom <- subset(df_1, category == 'eCom')
df_2_ecom <- subset(df_2, category == 'eCom')

reg_1_eCom <- lm(Score ~ factor(adType)+factor(placement)+ageMean, data=df_1_ecom)
reg_2_eCom <- lm(Score ~ factor(adType)+factor(placement)+ageMean, data=df_2_ecom)

intervals <- data.frame(matrix(ncol = 3, nrow = 0))
pred_info <- data.frame(matrix(ncol = 1, nrow = 0))

for (a in c('Photo Post', 'Link Post')){
    for (b in c('mobile', 'desktopfeed')){
        for (c in c(20, 30, 40, 50)){
            for (d in list(reg_1_eCom, reg_2_eCom)){
                pred_info <- rbind(pred_info, paste(a, b, toString(c), sep = ", "))
                intervals <- rbind(intervals, predict(d, data.frame(adType = a, placement = b, ageMean = c), interval = 'confidence'))
            }
        }
    }
}

colnames(pred_info) <- c('info')
colnames(intervals) <- c('fit', 'lwr', 'upr')
intervals <- cbind(pred_info, intervals)
write.csv(intervals, "intervals for eCom.csv")

#reg 3
reg3 <- lm(Score~ factor(date)+factor(adType)+factor(category)+
               factor(placement)+ factor(keywords)+factor(body)+ageMean
           +factor(category)*ageMean, data = df)

#plot_summs(reg1)
#plot_summs(reg2)
#plot_summs(reg1, reg2, model.names = c('3/26/2013', '4/27/2013'))

