PISAUKIM <- PISA_2018 %>%
  select(CNT, IMMIG) %>%
  filter(CNT=="United Kingdom")%>%
  droplevels()
PISAUKIAH <- PISA_2018 %>%
  select(CNT, IC001Q04TA) %>%
  filter(CNT=="United Kingdom")%>%
  droplevels()
PISAIM <- PISA_2018 %>%
  select(IMMIG)%>%
  droplevels()
PISAIAH <- PISA_2018 %>%
  select(IC001Q04TA)%>%
  droplevels()
IMFREQTABLE <-xtabs(data=PISAIM,~IMMIG)
print(IMFREQTABLE)
IAHFREQTABLE <-xtabs(data=PISAIAH,~IC001Q04TA)
print(IAHFREQTABLE)

IMANDIAT <- PISA_2018 %>%
  select(IMMIG,IC001Q04TA)%>%
  filter(IMMIG!="NA"&IC001Q04TA!="NA")%>%
  droplevels()
ggplot(data=IMANDIAT)+geom_mosaic(aes(x = product(IMMIG, IC001Q04TA), fill=IMMIG))
chisq.test()