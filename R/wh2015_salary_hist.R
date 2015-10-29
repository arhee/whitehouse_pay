library(ggplot2)
library(plyr)

cols = c('#CC6699', '#008AB8')
mydata = read.csv("../proc_data/df2015_forR.csv")


mydata$Gender <- revalue(mydata$Gender, c('female'='Female', 'male'='Male'))

mydata$Sal_Bin <- cut(mydata$Salary, c(seq(40000,140000,20000), 200000))
lbl <- c('$40-$60k','$60-$80k','$80-$100k','$100-$120k','$120-$140k','$140k+')

f = ggplot(mydata, aes(x=Sal_Bin, fill=Gender)) + 
  geom_bar(position='dodge', binwidth=20000) + 
  scale_fill_manual(values = cols) + 
  scale_x_discrete(labels=lbl) + 
  geom_vline(xintercept=2.5, size=1, color='#777777') + 
  geom_vline(xintercept=5.5, size=1, color='#777777') + 
  ylab("Count") + xlab("Salary") + 
  ggtitle('WH Salaries (2015)') + 
  theme_minimal()


png('../figs/wh2015_salary_hist.png', width=1200, height=800, res=150)
print(f)
dev.off()