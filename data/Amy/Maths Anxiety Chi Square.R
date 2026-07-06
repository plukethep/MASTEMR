install.packages("tidyverse")
install.packages("openxlsx")
library(tidyverse)
library(openxlsx)
results <- read.xlsx("/Users/richardbrock/Documents/Work/Teaching/STEM MA/Quantitative module/Teaching/Chi Square Session/Maths Anxiety and Gender.xlsx")


chisq <- chisq.test(results)
sink(file="/Users/richardbrock/Documents/Work/Teaching/STEM MA/Quantitative module/Teaching/Chi Square Session/AnxietyGenderChi.txt")
print(chisq)
sink()