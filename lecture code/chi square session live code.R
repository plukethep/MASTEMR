library(tidyverse)
library(arrow)  
library(ggmosaic)
library(RVAideMemoire)
library(dplyr)

PISA_2022 <- read_parquet(r"[/Users/amyobrien/Downloads/PISA_student_2022_subset.parquet]")

GENDERVSCNT <- PISA_2022 %>%
  select(ST004D01T,CNT)%>%
  filter(CNT=="United Kingdom"|CNT=="United States")%>%
  filter(ST004D01T!="NA")%>%
  droplevels()

GENDERVSCNTContTable <- xtabs(data=GENDERVSCNT,~ST004D01T+CNT)
GENDERVSCNTContTable

ggplot(data=GENDERVSCNT)+geom_mosaic(aes(x = product(CNT,ST004D01T), fill=ST004D01T))

GENDER <- PISA_2022 %>%
  select(ST004D01T)%>%
  filter(ST004D01T!="NA")%>%
  droplevels()

GENDERContTABLE <- xtabs(data=GENDER)
GENDERContTABLE

chisq.test(GENDERContTABLE,p=c(1/2,1/2))

GENDERVSSWOT <- PISA_2022 %>%
  select(ST004D01T,ST324Q11JA)%>%
  filter(ST004D01T!="NA"&ST324Q11JA!="NA")%>%
  droplevels()

GENDERVSSWOTCT <-xtabs(data=GENDERVSSWOT,~ST004D01T+ST324Q11JA)
GENDERVSSWOTCT

ggplot(data=GENDERVSSWOT)+geom_mosaic(aes(x = product(ST004D01T,ST324Q11JA), fill=ST004D01T))
chisq.test(GENDERVSSWOTCT)


kruskal.test(data=GENDERVSSWOT,ST004D01T~ST324Q11JA)
