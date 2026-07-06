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

library(conflicted)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::summarise)
conflicts_prefer(brms::ar)
conflicts_prefer(quanteda::dictionary)
conflicts_prefer(lubridate::duration)
conflicts_prefer(MASS::geyser)
conflicts_prefer(brms::kidney)
conflicts_prefer(dplyr::lag)
conflicts_prefer(datawizard::mean_sd)
conflicts_prefer(datawizard::median_mad)
conflicts_prefer(modeest::skewness)
conflicts_prefer(modelbased::standardize)
conflicts_prefer(utils::timestamp)
#load data
PISA_2018 <- read_parquet(r"[/Users/amyobrien/Documents/PISA_2018_student_subset.parquet]")
#null hypothesis for one sample t-test

PISADICTIONARY <-PISA_2018%>%
  select(ST011Q12TA,ST013Q01TA) %>%
  filter(ST011Q12TA!="NA"&ST013Q01TA!="NA") %>%
  droplevels()

table(PISADICTIONARY)

levels(PISADICTIONARY$ST011Q12TA)
levels(PISADICTIONARY$ST013Q01TA)



kruskal.test(ST013Q01TA~ST011Q12TA,data=PISADICTIONARY)

library("ggpubr")

library(dplyr)
group_by(PISADICTIONARY, ST011Q12TA) %>%
  summarise(
    count = n())

PISAMATHSMINS <- PISA_2018 %>%
  select(MMINS,ST004D01T) %>%
  filter(MMINS!="NA"&ST004D01T!="NA")%>%
  droplevels()

levels(PISAMATHSMINS$ST004D01T)
levels(PISAMATHSMINS$MMINS)

table(PISAMATHSMINS)

group_by(PISAMATHSMINS, ST004D01T) %>% summarise(count = n(), median = median(MMINS, na.rm = TRUE),IQR=IQR(MMINS,na.rm=TRUE))

install.packages("ggpubr")

library("ggpubr")

ggboxplot(PISAMATHSMINS, x = "ST004D01T", y = "MMINS", 
          ylab = "Time Maths", xlab = "Gender")

kruskal.test(MMINS~ST004D01T,PISAMATHSMINS)

Q <- quantile(PISAMATHSMINS$MMINS, probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(PISAMATHSMINS$MMINS)
up <-  Q[2]+1.5*iqr # Upper Range  
low<- Q[1]-1.5*iqr # Lower Range


eliminated<- subset(PISAMATHSMINS, PISAMATHSMINS$MMINS > (Q[1] - 1.5*iqr) & PISAMATHSMINS$MMINS < (Q[2]+1.5*iqr))
ggboxplot(eliminated, x = "ST004D01T", y = "MMINS", 
          ylab = "Time Maths", xlab = "Gender")

kruskal.test(MMINS~ST004D01T,eliminated)
