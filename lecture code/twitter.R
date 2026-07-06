library(tidyverse)
library(arrow)
library(jsonlite)
library(streamR)
library(glue)

# require(readtext)
# # Twitter json
# dat_json <- readtext("social_media/zombies/tweets.json")

# PISA_2018 <- read_parquet(r"[/Users/susanacastro/Downloads/PISA_2018_student_subset.parquet]")
# /Users/susanacastro/Downloads/PISA_2018_student_subset (1).parquet
# 
# /Users/susanacastro/Downloads
# PISA_2018 %>%
#   mutate(mats_better=PV1MATH>PV1READ)%>%
#   select (CNT, ST004D01T, maths_better, PV1MATH, PV1READ)
# 
# fle <- read_json_arrow(r"[/Users/susanacastro/Downloads/twitter/medium.jsonl]")
# /Users/susanacastro/Desktop/CRESTEM/twitter
# 
# twt <- read_json(r"[/Users/susanacastro/Downloads/twitter/big.jsonl]")
# twt <- stream_in(file(r"[/Users/susanacastro/Downloads/twitter/big.jsonl]"))

# stream_in()
# twt <- read_json(r"[/Users/susanacastro/Downloads/twitter/big.jsonl]")
# twt <- stream_in(path=r"[/Users/susanacastro/Downloads/twitter/big.jsonl]")
# write_parquet(r"[/Users/susanacastro/Downloads/twitter/big.parquet]")
# 

fld <- "/Users/susanacastro/Downloads/twitter/"
fld <- "D:\\Data\\twitter\\"

fle <- glue("{fld}big.jsonl")
thetweets <- readLines(fle)
orig_n <- length(thetweets)
splts <- 1000

start <- 1
stop<- 2000
n<-2
dead_list <- c(4001)

for(n in 1:(orig_n%/%splts)){
  message(n)
  start <- ifelse(n==1, 1, (n * splts) + 1) 
  stop <- ifelse((n+1) * splts > orig_n, orig_n, (n+1) * splts)
  
  if(file.exists(glue("{fld}big{n}.parquet"))){
    message("SKIPPING", "thetweets[",start,":",stop,"]")
  }else{
    message("thetweets[",start,":",stop,"]")
    
    tweets <- data.frame()
    for(t in start:stop){
      # t=13001
      # message(t)
      twt <- tryCatch(
        {
          # parseTweets(thetweets[setdiff(c(start:stop),dead_list)])
          parseTweets(thetweets[t], verbose = FALSE)
        },
        error=function(cond) {
          message(paste(t, "has an error"))
          message(cond)
          # Choose a return value in case of error
          return("")
        })
      # message(twt)
      if(length(twt) > 1){
        if(ncol(tweets) == 0){
          tweets <- twt
        }else{
          tweets <- rbind(tweets, twt)
        }
        
      }
    }
    
    # twt <- stream_in(thetweets[start:stop])
    message("writing", n)
    write_parquet(tweets,glue("{fld}big{n}.parquet"))
  }
}

######## load other jsonl files

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

# TODO: filter out edutweets!

# load ALL the parquet files into one
twt <- data.frame()
for(fle in fles){
  message(fle)
  twt <- rbind(twt, read_parquet(glue("D:/Data/twitter/{fle}.parquet")))
}

write_parquet(twt, glue("D:/Data/twitter/combined/edutweets.parquet"))

twit <- twt %>% 
  select(-c("country_code", "in_reply_to_status_id_str", "expanded_url", "url", 
            "place_type", "geo_enabled", "user_id_str")) %>%
  mutate(across(c("place_lat", "place_lon", "lat", "lon"), \(x) round(x,2)))
twt %>% names()
name, user_id_str
twt %>% pull(user_id_str) 



, truncated, user_url,utc_offset,time_zone)





