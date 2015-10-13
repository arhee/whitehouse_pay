library(ggplot2)
library(plyr)

cols = c('#CC6699', '#008AB8')

mydata = read.csv('../proc_data/six_year_outcomes_60.csv')
mydata$Gender <- revalue(mydata$Gender, c('female'='Female', 'male'='Male'))

p = ggplot(mydata, aes(x=Y6_Served, y=Y6_Max_Salary)) + geom_point(color='#999999', alpha=0.5)  + geom_smooth(method=lm, se=FALSE, color='#777777') + labs(x='Years Served', y='Max Salary Achieved') + scale_y_continuous(breaks=seq(0,200000,50000), labels=c('$0','$50k','$100k', '$150k','$200k'), limits=c(0,200000)) + scale_x_discrete(breaks=seq(1,6)) + ggtitle('Max Salary Achieved vs. Years Served')

png('../figs/salary_served_scat.png', width=1200, height=800, res=150)
print(p)
dev.off()

#+ scale_color_manual(values = cols)