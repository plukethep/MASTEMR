install.packages("tidyverse")
library(tidyverse)
library(glue)
library(openxlsx)
library(readxl)
library(ggmosaic)  # for Amy's chapter on chi square
install.packages("arrow")
library(arrow)
install.packages("read_parquet")
#Load PISA 2018 data
PISA_2018 <- read_parquet(r"[/Users/amyobrien/Documents/PISA_2018_student_subset.parquet]")

#Example 1

#Define Gender Variable
GENDER <- PISA_2018 %>% 
  select(ST004D01T) %>%
  filter(ST004D01T!="NA") %>%
  droplevels()

#Gender Contigency Table
GENDERContTable <- xtabs(data=GENDER)
GENDERContTable

#Chi-Square test
chisq.test(GENDERContTable,p=c(1/2,1/2))

#Example 2

#Define Immigration Status Variable
PISAIM <- PISA_2018 %>%
  select(IMMIG)%>%
  droplevels()

#Define Internet At Home Variable
PISAIAH <- PISA_2018 %>%
  select(IC001Q04TA)%>%
  droplevels()

#Immigration Table
IMFREQTABLE <-xtabs(data=PISAIM,~IMMIG)
print(IMFREQTABLE)

#Internet at home Table
IAHFREQTABLE <-xtabs(data=PISAIAH,~IC001Q04TA)
print(IAHFREQTABLE)

#Immigration and Internet at home data set
IMANDIAT <- PISA_2018 %>%
  select(IMMIG,IC001Q04TA)%>%
  filter(IMMIG!="NA"&IC001Q04TA!="NA")%>%
  droplevels()

#Immigration and Internet at home Contigency Table
ContTable<-xtabs(data=IMANDIAT, ~IMMIG + IC001Q04TA)
ContTable

#Mosiac Plot
ggplot(data=IMANDIAT)+geom_mosaic(aes(x = product(IMMIG, IC001Q04TA), fill=IMMIG))

#Chi-Square test
chisq.test(ContTable)