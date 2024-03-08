
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

- Demographic data for coronavirus (COVID-19) testing (England): 28 May to 26 August (no date) GOV.UK. Available at: https://www.gov.uk/government/publications/demographic-data-for-coronavirus-testing-england-28-may-to-26-august/demographic-data-for-coronavirus-covid-19-testing-england-28-may-to-26-august (Accessed: 8 March 2024).
- Yang, Z.-R. et al. (2023) ‘Efficacy of SARS-CoV-2 vaccines and the dose–response relationship with three major antibodies: a systematic review and meta-analysis of randomised controlled trials’, The Lancet Microbe, 4(4), pp. e236–e246. Available at: https://doi.org/10.1016/S2666-5247(22)00390-1.


### Simulated_Datasets_Observational.R

- Bernal, J.L. et al. (2021) ‘Early effectiveness of COVID-19 vaccination with BNT162b2 mRNA vaccine and ChAdOx1 adenovirus vector vaccine on symptomatic disease, hospitalisations and mortality in older adults in England’. medRxiv, p. 2021.03.01.21252652. Available at: https://doi.org/10.1101/2021.03.01.21252652.
- Demographic data for coronavirus (COVID-19) testing (England): 28 May to 26 August (no date) GOV.UK. Available at: https://www.gov.uk/government/publications/demographic-data-for-coronavirus-testing-england-28-may-to-26-august/demographic-data-for-coronavirus-covid-19-testing-england-28-may-to-26-august (Accessed: 8 March 2024).


### Simulated_Datasets_External.R

- Cases in England | Coronavirus in the UK (2023). Available at: https://coronavirus.data.gov.uk/details/cases?areaType=nation&areaName=England (Accessed: 28 February 2024).
- Demographic data for coronavirus (COVID-19) testing (England): 28 May to 26 August (no date) GOV.UK. Available at: https://www.gov.uk/government/publications/demographic-data-for-coronavirus-testing-england-28-may-to-26-august/demographic-data-for-coronavirus-covid-19-testing-england-28-may-to-26-august (Accessed: 8 March 2024).
- Statistics » COVID-19 vaccinations archive (no date). Available at: https://www.england.nhs.uk/statistics/statistical-work-areas/covid-19-vaccinations/covid-19-vaccinations-archive/ (Accessed: 28 February 2024).





