
library(tidyverse)
library(arrow)
library(jsonlite)
library(streamR)
library(glue)

# X.1 Pre-reading
# X.2 Pre-seminar tasks
# X.3 Introduction to the test
# (Link to Navarro)
# X.4 Assumptions of the test
# (Link to Navarro)
# X.5 Description of the test
# (Link to Navarro)
# X.6 Examples of performing the test in R
# X.7 Seminar tasks
# X.8 Extension tasks and additional reading
# [Including paper recreations]

#####################################
################ TWITTER ############
#####################################

twt <- read_json_arrow(r"[D:\Data\twitter\2023-04-10T18_51_01.jsonl]")
twt <- stream_in(file(r"[D:\Data\twitter\2023-04-10T18_51_01.jsonl]"))

twt <- fromJSON(file = r"[D:\Data\twitter\2023-04-10T18_51_01.jsonl]")
write_parquet(twt, r"[D:\Data\twitter\2023-04-10T18_51_01.parquet]")

fles <- list.files(r"[D:\Data\twitter\]") %>% 
  as.data.frame()
names(fles) <- "nme"
fles <- fles %>% filter(grepl("jsonl", nme)) %>% pull(nme) %>% gsub(".jsonl", "", .)

for(fle in fles){
  message(fle)
  twt <- parseTweets(glue("D:/Data/twitter/{fle}.jsonl"))
  write_parquet(twt, glue("D:/Data/twitter/{fle}.parquet"))
}

# combine parquet
fles <- list.files(r"[D:\Data\twitter\]") %>% 
  as.data.frame()
names(fles) <- "nme"
fles <- fles %>% filter(grepl("parquet", nme)) %>% pull(nme) %>% gsub(".parquet", "", .)

twt <- data.frame()
for(fle in fles){
  message(fle)
  twt <- rbind(twt, read_parquet(glue("D:/Data/twitter/{fle}.parquet")))
}

twit <- twt %>% 
  select(-c("country_code", "in_reply_to_status_id_str", "expanded_url", "url", 
            "place_type", "geo_enabled", "user_id_str")) %>%
  mutate(across(c("place_lat", "place_lon", "lat", "lon"), \(x) round(x,2)))
twt %>% names()
name, user_id_str
twt %>% pull(user_id_str) 

, truncated, user_url,utc_offset,time_zone)

write_parquet(twit, glue("D:/Data/twitter/edutweets_smaller.parquet"))





twt <- parseTweets(r"[D:\Data\twitter\2023-04-10T18_51_01.jsonl]")

graph_data <- PISA_2015 %>% 
  filter(CNT %in% c("United Kingdom", "Korea")) %>% 
  dplyr::select(any_of(c("CNT", "ST004D01T", "PV1MATH", "cps_avg", 
                         "PV1SCIE", "ST004D01T", "IC008Q05TA", 
                         "IC008Q04TA", "IC008Q02TA"))) %>% 
  drop_na() %>%
  rename(gender = ST004D01T)
  
dodge <- position_dodge(width = 0.5)
ggplot(data=graph_data, aes(x = factor(IC008Q02TA), fill=CNT)) +
  geom_violin(aes(y = PV1MATH), position = dodge, alpha = 0.2) +
  geom_boxplot(aes(y = PV1MATH), position = dodge, width = 0.2, outlier.shape = NA) +
  labs(x = "Frequency Collaborative Online Gaming (1 'never' to 5 'everyday')",
       y = "CPS Average Scores") +
  ggtitle("Violin Plot: CPS vs. Frequency of Playing Collaborative Online Games") +
  # scale_x_discrete(drop = FALSE) +
  scale_fill_manual(values = c("United Kingdom" = "lightblue", "Korea" = "yellow"),
                     labels = c("UK", "SK"),
                     name = "Country") +
  facet_grid(gender ~ .)




loc <- r"[C:\Users\Peter\Google Drive\Kings\Code\PISR\Data\PISA\subset\PISA_2015_student_FULL.parquet]"
PISA_2015 <- read_parquet(loc)
loc <- r"[C:\Users\Peter\Google Drive\Kings\Code\PISR\Data\PISA\2018\PISA_2018_student.parquet]"
loc <- r"[C:\Users\Peter\Google Drive\Kings\Code\PISR\Data\PISA\2018\PISA_2018_student.parquet]"

PISA_2018 <- read_parquet(loc)

PISA_2015$ST113Q01TA

PISA_2015_tmp <- PISA_2015 %>% 
  select(ST113Q01TA, ST004D01T, WEALTH) %>% 
  na.omit() %>%
  mutate(ST113Q01TA = as.numeric(ST113Q01TA),
         ST004D01T = as.numeric(ST004D01T))

mdl_careerasp <- lm(ST113Q01TA ~ ST004D01T + WEALTH, data=PISA_2015_tmp)
summary(mdl_careerasp)

PISA_2015 %>% filter(!is.na(CPSVALUE)) %>% pull(CPSVALUE)
PISA_2015$CPS

tmp <- PISA_2015 %>% filter(!is.na(CPSVALUE)) %>% 
  group_by(CNT, ST004D01T) %>%
  summarise(CPSmin = min(CPSVALUE),
            CPSmax = max(CPSVALUE),
            CPSmed = median(CPSVALUE),
            CPSmean = mean(CPSVALUE))

tmp %>% filter(CNT %in% c("United Kingdom", "Korea"))


df <- PISA_2018 %>%
  rename(gender = ST004D01T) %>%
  select(CNT, gender, IC008Q02TA) %>%
  filter(CNT %in% c("Korea", "Singapore", "United Kingdom")) %>%
  drop_na() %>%
  group_by(CNT, gender) %>%
  mutate(total_stu = n()) %>% # total students for each CNT and gender grouping
  group_by(CNT, gender, IC008Q02TA) %>%
  summarise(per = n() / unique(total_stu) * 100) %>%
  ungroup()

ggplot(data = df,
       aes(x=gender, y=per, fill=IC008Q02TA)) +
  geom_bar(stat="identity", position = position_dodge()) +
  facet_grid(CNT ~ .)



DfE_SEN_data %>% 
  group_by(district_administrative_name) %>% 
  summarise(SEN_support = sum(SEN.support),
            EHCplan = sum(EHC.plan),
            Total = sum(Total.pupils))


check <- TRUE

PISA_2018 %>% 
  select(PV1MATH, PV1READ) %>% 
  na.omit() %>%
  cor()

cor(PISA_2018 %>% select(PV1MATH, PV1READ) %>% na.omit())

seq(0,1500,250)


PISA_2018 %>% 
  filter(CNT %in% c("United Kingdom", "Korea")) %>%
  group_by(CNT) %>%
  mutate(total = n()) %>%
  group_by(CNT, ST004D01T) %>%
  summarise(gender = n(),
            total = unique(total)) %>%
  ungroup() %>%
  mutate(gender / total)

PISA_2015$PV2CLPS

str(PISA_2018$LMINS)
DfE_SEN_data %>% rename_with(make.names) %>% names()
nto
?read_csv
# 
# library(ggmosaic)
# 
# rdr <- c("Outstanding", "Good", "Requires improvement", "Special Measures", "Inadequate") 
# rdr <- c("Outstanding", "Good", "Requires improvement", "Special Measures") 
# 
# Ofsted_ratings <- Ofsted_ratings %>% 
#   mutate(OfstedRating = factor(OfstedRating, 
#                                levels=rdr),
#         FSM_group = factor(FSM_group, 
#                            levels=c("Low", "Medium", "High")))
# 
#                           
#                           
#                           
# ggplot(data = Ofsted_ratings) +
#   geom_mosaic(aes(x = product(OfstedRating, 
#                               FSM_group), 
#                   fill = OfstedRating))
# 
# 
# # get long format for Anxiety formats, i.e. raw survey data
# 
# anx_3 <- pivot_longer(Anxietytable3 %>% 
#                         select(-Total) %>% 
#                         filter(Gender != "Total"), 
#              -Gender) %>% 
#   uncount(value)
# 
# anx_4 <- pivot_longer(Anxietytable4 %>% 
#                         select(-Total) %>% 
#                         filter(Age != "Total"), 
#                       -Age) %>% 
#   uncount(value)
# 
# anx_5 <- pivot_longer(Anxietytable5 %>% 
#                         select(-Total) %>% 
#                         filter(`Home Language` != "Total"), 
#                       -`Home Language`) %>% 
#   uncount(value)
# 
# # conduct chi-square tests
# chisq.test(anx_3$Gender, anx_3$name)
# chisq.test(anx_4$Age, anx_4$Age)
# chisq.test(anx_5$`Home Language`, anx_5$`Home Language`)
