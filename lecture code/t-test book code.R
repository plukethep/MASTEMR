library(tidyverse)

PISA_2018 <- read_parquet(r"[/Users/amyobrien/Documents/PISA_2018_student_subset.parquet]")
PISA_2018_Read_Girls <- PISA_2018 %>%
  select(CNT, PV1READ, ST004D01T) %>%
  filter(CNT=="United Kingdom"|ST004D01T=="Female")

install.packages("arrow")
library(arrow)
ggplot(data=PISA_2018_Read_Girls,
       aes(x=PV1READ)) +
  geom_histogram(binwidth = 5, fill="darkseagreen4")

