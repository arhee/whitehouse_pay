library(ggplot2)
cols = c('#CC6699', '#008AB8')
mydata = read.csv("../proc_data/df2015_forR.csv")

clean_df <- mydata[mydata$Est_Age != 'unknown', ]

mod1 <- lm(clean_df$Salary ~ clean_df$Est_Age)

p = ggplot(clean_df, aes(Est_Age, Salary)) + geom_point(alpha=0.2) + scale_y_continuous(limits=c(0,200000), breaks=seq(0,200000,50000), labels=c('0','$50k','$100k', '$150k', '$200k')) + scale_x_continuous(limits=c(20,60)) + labs(x='Estimated Age') + geom_smooth(method=lm, se=FALSE, color='#777777', size=0.5) + ggtitle('2015 WH Salary vs. Estimated Age') + geom_hline(yintercept=60000, size=0.5, color='red')


png('../figs/salary_age_scat.png', width=1200, height=800, res=150)
print(p)
dev.off()