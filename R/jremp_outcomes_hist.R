library(ggplot2)
library(plyr)

cols = c('#CC6699', '#008AB8')
mydata = read.csv('../proc_data/six_year_outcomes_60.csv')

df = data.frame(Gender = mydata$Gender, Max_Salary = mydata$Y6_Max_Salary) 


df$Gender <- revalue(df$Gender, c('female'='Female', 'male'='Male'))

#df$Bin <- cut( df$Max_Salary, c(0, 80000, 100000, 120000, 200000))
#p = ggplot(df, aes(x=Bin)) + geom_bar(binwidth=20000, fill='#999999') + scale_fill_manual(values = cols) + scale_x_discrete(labels=c('< $80k', '$80k-$100k','$100k-$120k','$120k+')) + labs(x='Max Salary Achieved', y='Count')

df$Bin <- cut( df$Max_Salary, c(0, 60000, 80000, 100000, 120000, 200000))

p = ggplot(df, aes(x=Bin, fill=Gender)) + geom_bar(binwidth=20000, position='dodge') + scale_fill_manual(values = cols) + scale_x_discrete(labels=c('<$60k','$60-80k', '$80k-$100k','$100k-$120k','$120k+')) + labs(x='Max Salary Achieved', y='Count')  + scale_fill_manual(values = cols) + ggtitle('Max Salary Achieved by 2009-2010 Junior WH Employees')


png('../figs/jremp_outcomes_hist.png', width=1200, height=800, res=150)
print(p)
dev.off()