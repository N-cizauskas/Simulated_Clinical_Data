
# Simulated_Clinical_Data


## Description

This contains R code for simulating clinical data of three different types (randomized control trial, observational study, and external data) based on probabilities from COVID-19 data.  Data comes from February-August 2021 in the United Kingdom. The outcome being looked at is testing positive for COVID-19, and the treatment/exposure variable of interest is the BNT162b2 Pfizer-BioNTech vaccine.  Ethnicity and sex are included as potential confounders in the RCT and observational study.  Simulated data is tested through a logisitc regression model to confirm previously published findings.

There are three separate code scripts, one for each datatype.

## Installation

Scripts can be downloaded and run in R Studio.

## Libraries

The R Libraries used include the following:

- tidyverse
- sandwich
- stargazer
- dplyr
- rtruncnorm

## Usage

This data can be used for testing clinical trial analysis methods that require three differnet dataset types.

## Citations

### Simulated_Datasets_RCT.R



### Simulated_Datasets_Observational.R



### Simulated_Datasets_External.R





