# The aim is to simulate three datasets representing external data,
# observational study data, and RCT data


# DATA INFO HERE 



# COVID-19 data was chosen to be simulated due to the accessibility of external data for COVID-19
# all datasets must have the same outcome (testing positive for COVID-19)



# probabilities of outcome will be based off of RCT data of reduced incidence of positive symptomatic infection after vaccine

#CITATIONS
# info about vaccine probabilties from:
# Yang, Z.-R. et al. (2023) ‘Efficacy of SARS-CoV-2 vaccines and the dose–response relationship with three major antibodies: a systematic review and meta-analysis of randomised controlled trials’, 
# The Lancet Microbe, 4(4), pp. e236–e246. Available at: https://doi.org/10.1016/S2666-5247(22)00390-1.
# vaccine data from the bnt162b2 vaccine


# all demographic info from:
# https://www.gov.uk/government/publications/demographic-data-for-coronavirus-testing-england-28-may-to-26-august/demographic-data-for-coronavirus-covid-19-testing-england-28-may-to-26-august


# for age
# normal distribution from ages 0-90



# import packages
library(tidyverse)
library(sandwich)
library(stargazer)
library(dplyr)
library(rtruncnorm)


# simulate the data
set.seed(9999)
N = 10000

# creating the dataframe
df <- data.frame(treat=sample(c(1,0), N,replace=TRUE, prob=c(.5,.5)), # treat is the indicator for treatment and control, treatment is recieving vaccine
                 comply=sample(c(1,0), N,replace=TRUE, prob=c(1,0)), # comply is whether the patient complies (if treatment, takes treatment, if control, takes control)
                 sex=rbinom(N, 1, .554),
                 race=sample(c(1,2,3,4), N, replace=TRUE, prob=c(.079, .028, .018, .689)), 
                 #1 = asian, 2 = black, 3 = mixed, 4= white
                 age = rtruncnorm(N, a=10, b=80, mean=42, sd=20),
                 random_var=rbinom(N,1,prob=.5), # gen a random variable
                 post=0
)

# rounds ages to whole numbers
df$age <- round(df$age, 0)

# add variable id
df <- df %>% dplyr::mutate(id=row_number())


# copy df and change variable post to 1 for after treatment effect
df2 <- df %>% mutate(post=1)

# add them together
df <- rbind(df, df2)
rm(df2)


# define treatment effect 
df <- df %>% mutate(treat_effect=
              ifelse(treat==1 & comply==1, .004, # true treatment effect
              ifelse(treat==1 & comply==0, .04,       
              ifelse(treat==0 & comply==1, .04,       
              ifelse(treat==0 & comply==0, .04, NA)))))

# only post-treatment group should have treatment effect
df <- df %>% dplyr::mutate(treat_effect=ifelse(post==0, NA, treat_effect))

table(df$treat, exclude=NULL)


# sex and race effect
# values show probability of each tested positive case being the specific demographic
# calculated by number of tested positive in each group over number of tested in each group
df <- df %>% mutate(sex_effect=
              ifelse(sex==1, .02,
              ifelse(sex==0, .02,       
              NA))) # since they are the same, will not be added to overall_treatment

df <- df %>% mutate(race_effect=
              ifelse(race==1,.01,
              ifelse(race==2,0,
              ifelse(race==3,0,
              ifelse(race==4,0,
              NA)))))



# create an overall treat effect including demo influences
df <- df %>% mutate(overall_treat_effect= treat_effect+race_effect)



# create pre and post outcomes
# outcome is testing (negative or positive) for COVID
df$outcome <- rbinom(nrow(df), 1, df$overall_treat_effect)
df$outcome[df$post==0] <- rbinom(nrow(df[df$post==0, ]), 1, 0.04)




# run example regression of outcome and explanatory variables
summary(glm(outcome~treat+race,family=binomial, data=df))
