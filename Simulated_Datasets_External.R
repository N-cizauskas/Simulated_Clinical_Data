# The aim is to simulate three datasets representing external data,
# observational study data, and RCT data


# DATA INFO HERE 



# simulating external data will have no exposure being tested
# just case/control split, number of vaccinated people
# involves making the dataset based on population statistics, then testing the regression directly from that


# all case and vax data from gov websites for england in early march 2021
# https://coronavirus.data.gov.uk/details/cases?areaType=nation&areaName=England
# https://www.england.nhs.uk/statistics/statistical-work-areas/covid-19-vaccinations/covid-19-vaccinations-archive/

# all demographic info from:
# https://www.gov.uk/government/publications/demographic-data-for-coronavirus-testing-england-28-may-to-26-august/demographic-data-for-coronavirus-covid-19-testing-england-28-may-to-26-august





# for age
# normal distribution from ages 0-90




# import packages
library(tidyverse)
library(sandwich)
library(stargazer)
library(dplyr)
library(truncnorm)

# simulate the data
set.seed(9999)
N = 5000

# creating the dataframe
df <- data.frame(case=sample(c(1,0), N,replace=TRUE, prob=c(.001,.999)), # case is testing positive/negative for COVID
                 treatment=sample(c(1,0), N,replace=TRUE, prob=c(.36,.64)), # whether person has recieved vaccine yet
                 sex=rbinom(N, 1, .554),
                 race=sample(c(1,2,3,4), N, replace=TRUE, prob=c(.079, .028, .018, .689)), 
                 #1 = asian, 2 = black, 3 = mixed, 4= white
                 age = rtruncnorm(N, a=10, b=80, mean=42, sd=20)
                
)

# round age to whole number
df$age <- round(df$age, 0)

# add variable id
df <- df %>% dplyr::mutate(id=row_number())



# run example regression of outcome and eplanatory variables
summary(glm(case~treatment+race,family=binomial, data=df))

