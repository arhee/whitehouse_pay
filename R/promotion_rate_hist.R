library(plyr)
library(ggplot2)

cols = c('#CC6699', '#008AB8')
mydata = read.csv("../proc_data/six_year_outcomes_60.csv")
mydata$Gender <- revalue(mydata$Gender, c('female'='Female', 'male'='Male'))


mydata$Rate[is.na(mydata$Y6_dSalary)] <- 0
mydata$Rate[mydata$Y6_dSalary < 0] <- 0


mydata$Y6_RateBin <- cut(mydata$Y6_dSalary, c(-100000,seq(5000,20000,5000), 100000))


f = ggplot(mydata, aes(x=Y6_RateBin, fill=Gender)) + geom_histogram(binwidth=5000, position='dodge') + scale_fill_manual(values = cols) + labs(x='Salary Increase per Year', y='Count') + scale_x_discrete(labels=c('$0-$5k','$5-$10k','$10-$15k','$15-$20k','$20k+')) + ggtitle('Promotion Rates for 2009-10 Junior WH Employees')


png('../figs/promotion_rate_hist.png', width=1200, height=800, res=150)
print(f)
dev.off()