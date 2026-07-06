# install.packages(c("glue", "openslsx", "gt", "lsr", "nortest",
# " easystats", " multcomp", "ggmosaic", "psych", "tidyverse", "arrow", "broom",
# "ggrepel", "ggpubr", "random"))

# datasources loaded
# https://docs.google.com/spreadsheets/d/1Px5KVO698OPxHmX68NiIyKGEGWpqO-nH/edit#gid=2116375017

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
library(RVAideMemoire) # for Amy's chapter on chi square
library(broom)     # for the t-test chapter, final graph
library(ggpubr)
library(ggrepel)
library(modeest)  # for calculating the mode in Carla's session 3
library(tinytex)
library(tictoc)
#library(quanteda)
# install.packages("dgof")
# library(dgof) # removed this, not sure what it is needed for 2023-09-12
library(gridExtra) # For David's chapter
library(DiagrammeR) # For flow diagrams in the selecting tests chapter
library(tidyverse)
library(effsize)
library(rstatix)
library(apaTables)

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
conflicts_prefer(broom::bootstrap)
conflicts_prefer(dplyr::combine)
conflicts_prefer(tidyr::expand)
conflicts_prefer(tidyr::pack)
conflicts_prefer(tidyr::unpack)
conflicts_prefer(dplyr::recode)
conflicts_prefer(arrow::read_feather)
conflicts_prefer(ggplot2::gg_par)

options(max.print=40)
folder_images <- "images"
# test <- FALSE

# load file system, depending who it is
node <- Sys.info()

# Work laptop
if(node["nodename"] == "KCL8KWNXY2"){
  datafolder <- r"(C:\Users\w1926273\OneDrive - King's College London\Code\SCARI\)"
  base_location <- r"(G:\My Drive\Kings\Code\MASTEMR\data\)"
}else if(node["nodename"] == "PETES_PC"){
  # datafolder <- r"(C:\Users\Peter\Google Drive\Kings\Code\PISR\Data\PISA\)"
  # datafolder <- r"(G:\My Drive\Kings\Code\PISR\Data\PISA\)"
  # pisa_data <- r"[D:\OneDrive\KCL OneDrive\OneDrive - King's College London\Code\QERKCL_PISA\data\pisa\]"
  pisa_data <- r"[C:\Users\peter\OneDrive - King's College London\Code\QERKCL_PISA\data\pisa\]"
  # base_location <- r"(G:\My Drive\Kings\Code\MASTEMR\data\)"
  base_location <- r"[C:/Users/peter/OneDrive - King's College London/Code/MASTEMR/]"
  
}else if(node["nodename"] == "KCLJ7J6LFC74J"){ #Richard's Mac
  datafolder <- r"(/Users/k1765032/Google Drive/My Drive/PISR/data/PISA/)"
  pisa_data <- "/Users/k1765032/Library/CloudStorage/OneDrive-King'sCollegeLondon/QERKCL_PISA/data/pisa/"
  base_location <- "/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Peter Kemp\'s files - MASTEMR/"
  proj_location <- "/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Peter Kemp\'s files - MASTEMR/"
  proj_folder <- "/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Peter Kemp\'s files - MASTEMR/"
}else if(node["nodename"] == "KCL3Y7NKR3"){ #Pete's NEW Laptop
  datafolder <- r"(G:\My Drive\Kings\Code\PISR\Data\PISA\)"
  pisa_data <- r"(C:\Users\k1926273\OneDrive - King's College London\Code\QERKCL_PISA\data\pisa\)"
}else if(node["nodename"] == "KCLMLVXD9XH6P"){ #Pete's NEW Laptop
  datafolder <- r"(G:\My Drive\Kings\Code\PISR\Data\PISA\)"
  pisa_data <- "/Users/k1926273/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Code/QERKCL_PISA/data/pisa/"
  base_location <- "/Users/k1926273/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Code/MASTEMR/"
}else if(node["nodename"] == "Amys-MacBook-Air.local"){ #Pete's NEW Laptop
  datafolder <- r"(/Users/amyobrien/Google Drive/My Drive/Data/PISA/)"
  base_location <- r"(/Users/amyobrien/Google Drive/My Drive/MASTEMR/data/)"
}else{
  warning("Can't find PC name, using default folder location")
  datafolder <- r"(D:\OneDrive\KCL OneDrive\OneDrive - King's College London\Code\SCARI\)"
}

loc_amy <- glue("{base_location}data/")

# message("LOADING: PISA 2018 data")
# # PISA_2018 <- read_rds(loc)
# PISA_2018         <- read_parquet(glue("{datafolder}subset/PISA_2018_student_subset.parquet"))
# PISA_2018_school  <- read_parquet(glue("{datafolder}2018/PISA_2018_school.parquet"))
# PISA_2018_teacher <- read_parquet(glue("{datafolder}2018/PISA_2018_teacher.parquet"))

message("LOADING: PISA 2022 data")
# PISA_2018 <- read_rds(loc)


# PISA_2022         <- read_parquet(glue("{pisa_data}2022/PISA_student_2022.parquet"))
# write_feather(PISA_2022, glue("{pisa_data}2022/PISA_student_2022.feather"))
# PISA_2022_school  <- read_parquet(glue("{pisa_data}2022/PISA_school_2022.parquet"))
# write_feather(PISA_2022_school, glue("{pisa_data}2022/PISA_school_2022.feather"))
# PISA_2022_teacher <- read_parquet(glue("{pisa_data}2022/PISA_teacher_2022.parquet"))
# write_feather(PISA_2022_teacher, glue("{pisa_data}2022/PISA_teacher_2022.feather"))

pisa_2022_columns <- c("CNT","OECD","CNTSTUID","CNTSCHID","REGION","ST004D01T","PV1MATH","PV1READ","PV1SCIE",
                       "ESCS","OCOD1","OCOD2","ST003D02T","BELONG","ST003D02T","ST003D03T","WB150Q01HA","WB151Q01HA",
                       "WB152Q01HA","WB153Q01HA","WB153Q02HA","WB153Q03HA","WB153Q04HA","WB153Q05HA","WB154Q01HA",
                       "WB154Q02HA","WB154Q03HA","REPEAT","LANGN","LANGTEST_QQQ","OCOD3","IC172Q01JA","DISCLIM",
                       "ST355Q03JA","ST324Q11JA","ST251Q01JA","ST253Q01JA","WB171Q01HA","ST251Q06JA","ST038Q08NA",
                       "PA195Q01JA","ESCS","ST125Q01NA","FL150Q02TA","ST251Q01JA","WB178Q01HA","ST005Q01JA","ST250Q02JA",
                       "ST250Q01JA","ST261Q04JA","ST250Q05JA","ST007Q01JA","ST254Q03JA","ST254Q01JA","ST251Q06JA",
                       "WORKPAY","MATHPREF","MATHEASE","ST062Q02TA","MATHMOT","HISCED","PQMIMP","ATTCONFM","PARINVOL","PAREXPT","ICTEFFIC",
                       "ST337Q07JA","ST261Q01JA","ST256Q02JA", "ST337Q07JA","ST255Q01JA", "ST250Q03JA", "HOMEPOS", "WB155Q02HA", 
                       "ST016Q01NA", "WB150Q01HA","ST019AQ01T", "ST019BQ01T", "ST019CQ01T",
                       "WB156Q01HA", "WB158Q01HA", "WB160Q01HA","STUBMI",
                       "ST254Q01JA","ST254Q02JA","ST254Q03JA","ST254Q04JA","ST254Q05JA","ST254Q06JA", "ST251Q07JA", "BULLIED",
                       "W_FSTUWT")
additional_cols <- c("STUBMI",
                       "BODYIMA","SOCONPA","ICTDISTR","PAREXPT","ICTWKDY","ICTWKEND","ICTRES","SDLEFF","FEELLAH","FAMSUPSL",
                       "ANXMAT","FAMSUP","STRESAGR","ASSERAGR","EMPATAGR","COOPAGR","CURIOAGR","PERSEVAGR","SCHRISK",
                       "FEELSAFE","BSMJ","STUDYHMW", "MATHPERS", "WB150Q01HA", "WB156Q01HA", "ST258Q01JA", "IMMIG", 
                     "COBN_S", "COBN_M", "COBN_F", "CREATHME", "CREATACT", "CREATOR", "CREATOPN")

# pisa_2022_columns <- c(pisa_2022_columns, additional_cols)

# missing from 2022, but in 2018
# "ST113Q01TA" "IC011Q03TA" "IC009Q02TA"
# setdiff(pisa_2022_columns,names(PISA_2022))
PISA_2022         <- read_feather(glue("{pisa_data}2022/PISA_student_2022.feather"), col_select=all_of(pisa_2022_columns))
# PISA_2022 <- read_feather(glue("{pisa_data}2022/PISA_student_2022.feather")) # , col_select=all_of(pisa_2022_columns))
#write_parquet(PISA_2022, glue("{pisa_data}2022/PISA_student_2022_subset.parquet"))

PISA_2022_teacher <- read_feather(glue("{pisa_data}2022/PISA_teacher_2022.feather"))
PISA_2022_school <- read_feather(glue("{pisa_data}2022/PISA_school_2022.feather"), col_select = -one_of("test"))

PISA_2018 <- read_feather(glue("{pisa_data}2018/PISA_student_2018.feather"), 
                          col_select=c("CNT","PV1MATH","PV1READ", "PV1SCIE"))

message("LOADING: PISA 2015 data")
cols_2015 <- c("CNT", "ST004D01T", "PV1READ", "PV1SCIE", "PV1MATH", "SCIEEFF")
PISA_2015 <- read_parquet(glue("{pisa_data}2015/PISA_student_2015.parquet"),
                          col_select=all_of(cols_2015))

##### Load Amy's datasets
message("LOADING: Amy schools data")


# fetch gender parity index data for 2013 and repeating stoet geary
message("Loading gender parity")
GGGI <- read.csv(glue("{loc_amy}GGGI-2013.csv"))


# loc <- r"(G:\My Drive\Kings\Code\PISR\Data\PISA\2018\CY07_MSU_STU_QQQ.rds)"
# loc <- r"[C:\Users\Peter\Google Drive\Kings\Code\PISR\Data\PISA\2018\CY07_MSU_STU_QQQ.rds]"
# loc <- r"[C:\Users\Peter\Google Drive\Kings\Code\PISR\Data\PISA\subset\PISA2018studentbz2levelsDP2.rds]"
# 
# loc <- glue("{datafolder}subset/PISA2018studentbz2levelsDP2.rds")

# message("LOADING: PISA 2018 data")
# # PISA_2018 <- read_rds(loc)
# PISA_2018         <- read_parquet(glue("{datafolder}subset/PISA_2018_student_subset.parquet"))
# PISA_2018_school  <- read_parquet(glue("{datafolder}2018/PISA_2018_school.parquet"))
# PISA_2018_teacher <- read_parquet(glue("{datafolder}2018/PISA_2018_teacher.parquet"))

# loc <- glue("{datafolder}subset/PISA2015studentbz2levelsDP2.rds")

# PISA_2012 <- read_parquet(glue("{datafolder}subset/PISA_2012_student_subset.parquet"))

### write arrow parquet file
# write_parquet(PISA_2018, glue("{datafolder}subset/PISA_2018_parquet_book.parquet"))
# write_parquet(PISA_2015, glue("{datafolder}subset/PISA_2015_parquet_book.parquet"))

# start.time <- Sys.time()
# PISA_2015 <- read_parquet(glue("{datafolder}subset/PISA_2015_parquet_book.parquet"))
# end.time <- Sys.time()
# end.time - start.time






# delete rogue folder
# loc_index_fld <- paste0(gsub("data/$", "", loc_amy), "index_files")
# unlink(loc_index_fld, recursive=TRUE, force=TRUE)
# unlink(r"[G:\My Drive\Kings\Code\MASTEMR\index_files]", recursive=TRUE, force=TRUE)

# DfE_results_2018 <- read.xlsx(glue("{loc_amy}dfe_data.xlsx"),sheet="Results")#
# DfE_schools_2018 <- read.xlsx(glue("{loc_amy}dfe_data.xlsx"),sheet="Schools")
# write_rds(DfE_results_2018, glue("{loc_amy}dfe_2018_results.rds"), compress = "none")
# write_rds(DfE_schools_2018, glue("{loc_amy}dfe_2018_schools.rds"), compress = "none")

# DfE_results_2018 <- read_rds(glue("{loc_amy}Amy/dfe_2018_results.rds"))
# write_parquet(DfE_schools_2018, glue("{loc_amy}Amy/dfe_2018_schools.par"))
# DfE_schools_2018 <- read_rds(glue("{loc_amy}Amy/dfe_2018_schools.rds"))
# DfE_schools_2018 <- read_parquet(glue("{loc_amy}Amy/dfe_2018_schools.par"))
# 
# DfEdata20182019 <- read_xlsx(glue("{loc_amy}Amy/DfE Data 2019 for Seminar.xlsx"),"Filtered 3" )
# 
# DfE_2019 <- read_xlsx(glue("{loc_amy}Amy/DfE Data 2019 for Seminar.xlsx"),"Filtered" )
# DfE_2019 <- DfE_schools_2018




# # Anxiety_2018
# message("Loading Anxiety data")
# loc<-glue("{loc_amy}Amy/Table 3 Mutodi and Ngriande.xlsx")
# Anxietytable3<-read_excel(loc)
# loc<-glue("{loc_amy}Amy/Table 4 Mutodi and Ngriande.xlsx")
# Anxietytable4<-read_excel(loc)
# loc<-glue("{loc_amy}Amy/Table 5 Mutodi and Ngriande.xlsx")
# Anxietytable5<-read_excel(loc)


# ##### Load Carla's datasets
# message("LOADING: carla SEN data")
# # write_parquet(DfE_SEN_data, glue("{loc_amy}sen_school_level_underlying_data.par"))
# # DfE_SEN_data <- read.csv(glue("{loc_amy}sen_school_level_underlying_data.csv"))
# DfE_SEN_data <- read_parquet(glue("{loc_amy}sen_school_level_underlying_data.par"))

# cache all the files
# OpenAnalysis_load_ALL(use_cache = TRUE, report_cache_folder = report_cache_folder)


junk <- function(){
  
  PISA_2018 %>% 
    filter(!is.na(PV1MATH)) %>% # Vietnam no results?!
    select(CNT, ST004D01T, PV1MATH) %>%
    group_by(CNT) %>%
    nest(data = c(ST004D01T, PV1MATH)) %>%
    summarise(tt = map(data, function(df){
      t.test(df %>% filter(ST004D01T == "Female") %$% PV1MATH,
             df %>% filter(ST004D01T == "Male") %$% PV1MATH) %>% 
        tidy()
    })) %>% 
    unnest(tt)
  
  # tmp <- PISA_2018 %>% 
  #   filter(!is.na(PV1MATH)) %>% # Vietnam no results?!
  #   select(CNT, ST004D01T, PV1MATH) %>%
  #   group_by(CNT) %>%
  #   # nest(data = c(ST004D01T, PV1MATH)) %>%
  #   summarise(tt = t.test(
  #                    PISA_2018 %>% filter(ST004D01T == "Female", CNT==CNT) %>% pull(PV1MATH),
  #                    PISA_2018 %>% filter(ST004D01T == "Male", CNT==CNT) %>% pull(PV1MATH))) %>% 
  #         tidy()) %>% 
  #   unnest(data)
  #   summarise(tt = list(t.test(PV1MATH[ST004D01T == "Female"],
  #                         PV1MATH[ST004D01T == "Male"])$p.value)) # %>%
  #   # unnest(tt)
  # 
  # t.test(price[color=="E"], price[color=="I"])$p.value
  # ?pivot_wider
}

# copy_clean_chapters()
# copy_run(type="booklet")

## THIS CREATES THE WEBSITE
# copy_run(type="single")

