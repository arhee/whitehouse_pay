library(ggplot2)
library(plyr)

cols = c('#CC6699', '#008AB8')
mydata = read.csv('../proc_data/reten_data_60.csv')
mydata$Gender <- revalue(mydata$Gender, c('female'='Female', 'male'='Male'))


subdf <- mydata[ mydata$Type %in% c('New', 'Returning'), ]

p = ggplot(subdf, aes(Year, Count, color=Gender, fill=Gender)) + 
  geom_line(size=2) + scale_color_manual(values = cols) + 
  ggtitle('New and Returning Junior Employees at the WH (2010-2015)') + 
  facet_wrap(~Type) + 
  theme_minimal()


png('../figs/newreturn_jremp_timeplot.png', width=1200, height=800, res=150)
print(p)
dev.off()