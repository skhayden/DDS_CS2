#First I need to explore the data and clean any varaibles as needed
library(dplyr)
library(stringi)


setwd("~/SMU/MSDS6306 - Doing Data Science/CaseStudy2")

df = read.csv("Procrastination.csv")

#how big is the dataset
dim(df)
str(df)

questionsRaw = colnames(df)
questionsCleaned = gsub("\\.", " ", questionsRaw)

questionsCleaned = stri_trans_general(questionsCleaned, id="Title")
q12 = gsub(" ","", questionsCleaned)

#Fix number of sons columns
df$Number.of.sons = as.character(df$Number.of.sons)
df$Number.of.sons[df$Number.of.sons == "Male"] = "1"
df$Number.of.sons[df$Number.of.sons == "Female"] = "2"
df$Number.of.sons = as.numeric(df$Number.of.sons)

#Fix position years column
df$How.long.have.you.held.this.position...Years = round(df$How.long.have.you.held.this.position...Years,0)
df$How.long.have.you.held.this.position...Years[df$How.long.have.you.held.this.position...Years > 100] = NA

#Fix country of origin column
df$Country.of.residence[df$Country.of.residence == 0] = NA

#Fix current occupation column, need to combine similar \occupations
df$Current.Occupation[df$Current.Occupation == c(0, "please specify")] = NA

#Change column types to appropriate type

#make average values
df$AIPMEAN = rowMeans(select(df, contains("AIP")))
df$GPMEAN = rowMeans(select(df, contains("GP")))
df$DPMEAN = rowMeans(select(df, contains("DP")))
df$SWLSMEAN = rowMeans(select(df, contains("SWLS")))



