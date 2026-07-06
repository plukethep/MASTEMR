

PISA_2022 %>% select(where(is.numeric)) %>% names()

############################
####### Correlation ########
############################


mdl_data = PISA_2022 %>% filter(CNT == "Belgium", ST004D01T == "Male")

ggplot(data=PISA_2022 %>% filter(CNT == "United Kingdom"), 
       aes(x=PV1MATH, y=PV1SCIE)) +
  geom_point() +
  geom_smooth(method="lm")
cor.test(mdl_data$PV1MATH, 
         mdl_data$PV1SCIE, 
         method = "pearson")

# check for normality
# if < 0.05 then not normal
shapiro.test(mdl_data$PV1MATH)
ggplot(data=mdl_data, 
       aes(x=PV1MATH)) +
  geom_density()

ggplot(data=PISA_2022 %>% filter(CNT == "United Kingdom"), 
       aes(x=HOMEPOS, y=ICTEFFIC)) +
  geom_point(alpha=0.1) +
  geom_smooth(method="lm")

# cor.test
mdl_data <- PISA_2022 %>% select(HOMEPOS, ICTEFFIC) %>% na.omit()

tmp <- cor.test(mdl_data$HOMEPOS, mdl_data$ICTEFFIC, method = "pearson")
tmp <- lm(HOMEPOS ~ ICTEFFIC, data = mdl_data)

mdl_data$resid <- residuals(tmp)
ggplot(data = mdl_data, aes(x=HOMEPOS, y=resid)) + 
  geom_point()


####### Questions in Section 3.4

############################
####### Regression #########
############################


lm(formula = PV1MATH ~ PV1READ, data = PISA_2022) %>% summary()


1 point increase in reading, increases maths by 0.77 points
0.69 

lm(formula = PV1MATH ~ PV1SCIE, data = PISA_2022) %>% summary()

lm(formula = PV1MATH ~ PV1SCIE + ESCS + ST004D01T, 
   data = PISA_2022) %>% summary()



PISA_2022 %>% select(where(is.numeric)) %>% names()

# multivariate regression
PV1READ ~ PV1MATH + ST004D01T + ESCS

####### Questions in Section 4.3 and 5.3

######################################
####### Checking assumptions #########
######################################

# independence
library(car)
mdl <- lm(PV1READ ~ PV1MATH + ST004D01T + ESCS, 
          data = PISA_2022 %>% filter(CNT == "United Kingdom"))
durbinWatsonTest(mdl)

# No multicollinearity
library(car)
mdl <- lm(PV1READ ~ PV1MATH + PV1SCIE + ST004D01T, 
          data = PISA_2022 %>% filter(CNT == "United Kingdom"))
vif(mdl) 

# Normality
par(mfrow = c(2, 2))
plot(mdl)

#Homoscedasticity
library(olsrr)
mdl <- lm(PV1READ ~ PV1MATH + PV1SCIE + ST004D01T, 
          data = PISA_2022 %>% filter(CNT == "United Kingdom"))

ols_test_breusch_pagan(mdl)
