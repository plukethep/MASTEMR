library(glue)
library(openxlsx)
library(readxl)
library(gt)        # for html tables
library(arrow)     # for super fast data loading
library(lsr)       # for eta squared
library(nortest)   # normal test
library(easystats) # for report in David's Chapter
library(multcomp)  # for glht in David's Chapter
library(ggmosaic)  # for Amy's chapter on chi square
library(broom)     # for the t-test chapter, final graph
library(tidyverse)
library(ggpubr)
library(ggrepel)
library(modeest)  # for calculating the mode in Carla's session 3
# library(gptstudio)
# install.packages("gptstudio")
library(tinytex)
install.packages("quanteda")
library(quanteda)

install.packages("arrow")
library(arrow)
#load data
PISA_2018 <- read_parquet(r"[/Users/amyobrien/Documents/PISA_2018_student_subset.parquet]")
#null hypothesis for one sample t-test
OECD_ave_math <-(489)

#setting up variables
PISAUKMath <- PISA_2018 %>%
select(CNT, PV1MATH) %>%
  filter(CNT=="United Kingdom")
ggplot(data=PISAUKMath,
       aes(x=PV1MATH)) +
  geom_histogram(binwidth = 5, fill="darkseagreen4")

PISAUSMath <- PISA_2018 %>%
  select(CNT, PV1MATH) %>%
  filter(CNT=="United States")
ggplot(data=PISAUSMath,
       aes(x=PV1MATH)) +
  geom_histogram(binwidth = 5, fill="darkseagreen4")

PISAUKRead <- PISA_2018 %>%
  select(CNT, PV1READ) %>%
  filter(CNT=="United Kingdom")
ggplot(data=PISAUKRead,
       aes(x=PV1READ)) +
  geom_histogram(binwidth = 5, fill="darkseagreen4")

#one sample t-test
res1 <- t.test(PISAUKMath$PV1MATH, mu = OECD_ave_math)
print(res1)

res2 <- t.test(PISAUKMath$PV1MATH, mu = OECD_ave_math, alternative="less")
print(res2)

res3 <- t.test(PISAUKMath$PV1MATH, mu = OECD_ave_math, alternative="greater")
print(res3)

#two sample unpaired t-test

res4 <- t.test(PISAUKMath$PV1MATH,PISAUSMath$PV1MATH)
print(res4)

res5 <- t.test(PISAUKMath$PV1MATH,PISAUSMath$PV1MATH, alternative="less")
print(res5)

res6 <- t.test(PISAUKMath$PV1MATH,PISAUSMath$PV1MATH, alternative="greater")
print(res6)

#two sample paired t-test
res7 <- t.test(PISAUKMath$PV1MATH,PISAUKRead$PV1READ,paired=TRUE)
print(res7)

res8 <- t.test(PISAUKMath$PV1MATH,PISAUKRead$PV1READ,paired=TRUE,alternative="less")
print(res8)

res9 <- t.test(PISAUKMath$PV1MATH,PISAUKRead$PV1READ,paired=TRUE,alternative="greater")
print(res9)

