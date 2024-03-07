# The aim is to simulate three datasets representing external data,
# observational study data, and RCT data


# DATA INFO HERE 



# observational study from https://www.medrxiv.org/content/10.1101/2021.03.01.21252652v1.full-text
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
N = 5000

# creating the dataframe
df <- data.frame(exposed=sample(c(1,0), N,replace=TRUE, prob=c(.14,.76)), # exposed group has been exposed to the variable of interest (vaccine)
                 sex=rbinom(N, 1, .554),
                 race=sample(c(1,2,3,4), N, replace=TRUE, prob=c(.079, .028, .018, .689)), 
                 #1 = asian, 2 = black, 3 = mixed, 4= white
                 age = rtruncnorm(N, a=10, b=80, mean=42, sd=20),
                 dummy=rbinom(N,1,prob=.5),
                 post=0
)

# round age to whole number
df$age <- round(df$age, 0)

# add variable id
df <- df %>% dplyr::mutate(id=row_number())


# copy df and change variable post to 1 for after observation records
df2 <- df %>% mutate(post=1)

# add them together
df <- rbind(df, df2)
rm(df2)


# define exposure effect
df <- df %>% mutate(exposure_effect=
            ifelse(exposed==1, .26,
            ifelse(exposed==0, .36,       
            NA)))

table(df$exposed, exclude=NULL)

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


# create an overall exposure effect including demo influences
df <- df %>% mutate(overall_exposure_effect = exposure_effect+race_effect)



# create pre and post outcomes
# outcome is testing (negative or positive) for COVID
df$case <- rbinom(nrow(df), 1, df$overall_exposure_effect)
df$case[df$post==0] <- rbinom(nrow(df[df$post==0, ]), 1, 0.26)



# only after exposure has been observed can there be an exposure effect (post)
df <- df %>% dplyr::mutate(overall_exposure_effect=ifelse(post==0, NA, overall_exposure_effect))


# run example regression of outcome and eplanatory variables
summary(glm(case~exposed+race,family=binomial, data=df))

