library(glue)
library(openxlsx)
library(readxl)
library(gt)        # for html tables
library(arrow)     # for super fast data loading
library(lsr)       # for eta squared
library(nortest)   # normal test
library(easystats) # for report in David's Chapter
library(multcomp)  # for glht in David's Chapter
install.packages("broom")
library(broom)     # for the t-test chapter, final graph
library(tidyverse)
library(ggpubr)
library(ggrepel)
# library(gptstudio)
# install.packages("gptstudio")
library(tinytex)
install.packages("quanteda")
library(quanteda)

#load data
PISA_2022 <- read_parquet(r"[/Users/amyobrien/Downloads/PISA_student_2022_subset.parquet]")


#One Sample example

#setting up variables
OECD_ave_math <-(472)

PISAUKMath <- PISA_2022 %>%
  select(CNT, PV1MATH) %>%
  filter(CNT=="United Kingdom")

#checking normality/data
ggplot(data=PISAUKMath,
       aes(x=PV1MATH)) +
  geom_histogram(binwidth = 5, fill="darkseagreen4")

qqnorm(PISAUKMath$PV1MATH)
qqline(PISAUKMath$PV1MATH, col = "red")

#one sample t-test
t.test(PISAUKMath$PV1MATH, mu = OECD_ave_math)

t.test(PISAUKMath$PV1MATH, mu = OECD_ave_math, alternative="greater")

t.test(PISAUKMath$PV1MATH, mu = OECD_ave_math, alternative="less")

#Two Sample Unpaired example

#setting up variables
PISAUKMath <- PISA_2022 %>%
  select(CNT, PV1MATH) %>%
  filter(CNT=="United Kingdom")


PISAUSMath <- PISA_2022 %>%
  select(CNT, PV1MATH) %>%
  filter(CNT=="United States")


ggplot(data=PISAUSMath,
       aes(x=PV1MATH)) +
  geom_histogram(binwidth = 5, fill="darkseagreen4")

qqnorm(PISAUSMath$PV1MATH)
qqline(PISAUSMath$PV1MATH, col = "red")

Var1 <- var(PISAUKMath$PV1MATH, na.rm = TRUE)
Var2 <- var(PISAUSMath$PV1MATH, na.rm = TRUE)
Var1 / Var2


#two sample unpaired t-test
t.test(PISAUKMath$PV1MATH,PISAUSMath$PV1MATH,var.equal=TRUE)

t.test(PISAUKMath$PV1MATH,PISAUSMath$PV1MATH, alternative="greater")

t.test(PISAUKMath$PV1MATH,PISAUSMath$PV1MATH, alternative="less")

#Two Sample Paired example
PISAUKMath <- PISA_2022 %>%
  select(CNT, PV1MATH) %>%
  filter(CNT=="United Kingdom")

PISAUKRead <- PISA_2022 %>%
  select(CNT, PV1READ) %>%
  filter(CNT=="United Kingdom")

ggplot(data=MATHREADUK,
       aes(x=PV1READ)) +
  geom_histogram(binwidth = 5, fill="darkseagreen4")


MATHREADUK <- PISA_2022 %>%
  select(CNT, PV1MATH,PV1READ) %>%
  filter(CNT == 'United Kingdom')

qqnorm(MATHREADUK$PV1READ)
qqline(MATHREADUK$PV1READ, col = "red")

Var1 <- var(MATHREADUK$PV1MATH, na.rm = TRUE)
Var2 <- var(MATHREADUK$PV1READ, na.rm = TRUE)
Var1 / Var2

#two sample paired t-test
t.test(MATHREADUK$PV1MATH,MATHREADUK$PV1READ,paired=TRUE)

