library(plyr)
library(ggplot2)
cols = c('#CC6699', '#008AB8')
mydata = read.csv("../proc_data/six_year_outcomes_60.csv")

mydata$Gender <- revalue(mydata$Gender, c('female'='Female', 'male'='Male'))

p = ggplot(mydata, aes(x=Bin, fill=Gender)) + geom_bar(position='dodge')
#print(p)

f = ggplot(mydata, aes(x=Y6_Served, fill=Gender)) + 
  geom_bar(position='dodge', binwidth=0.5) + 
  scale_fill_manual(values = cols) + 
  labs(x='Years Served', y='Count') + 
  scale_x_continuous(limits=c(1,7), breaks=seq(1,6), labels=seq(1,6)) + 
  ggtitle('Years Served by 2009-2010 Junior WH Employees') +
  theme_minimal()

png('../figs/years_served_hist.png', width=1200, height=800, res=150)
print(f)
dev.off()