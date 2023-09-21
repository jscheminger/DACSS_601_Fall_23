#Sep 18 Examples

library(tidyverse)
library(mdsr)
presidential

#filter() example
GOP_Prez<-filter(presidential, party == "Republican")
GOP_Prez

#select() example
Prez_info<-select(presidential, name, party)
Prez_info



#Sep 20: 
##Demonstration: Loading Other Data Files:

#1. txt: the baby name files

##The Basic function for reading a data in .txt format is read.delim() and read.delim2().
#read.delim(): for reading “tab-separated value” files (“.txt”). By default, point (“.”) is used as decimal points.
#read.delim2(): for reading “tab-separated value” files (“.txt”). By default, comma (“,”) is used as decimal points.

txt_data <- read.delim("http://www.sthda.com/upload/boxplot_format.txt")

head(txt_data)

##If we are reading multiple .txt files into one data in R, 
##we will use create a list and use the map() and purrr, which we will be cover in week#5.

#2. sql: https://posit.co/blog/working-with-databases-and-sql-in-rstudio/




##Demonstration: Data Transformation

df <- tibble(
     catname = c("Tom", "Mike", "Erica", "R", "SAS", "Tom"),
     breed = c(1, 1, 2, 1, 2, 1),
     age = c(3, 2, 1, 3, 1, 3)
   )
df

#distrinct()
df_data<-distinct(df) 
df_data
#compare rows by rows to find if there is any rows have the same values in each column
#remove row#6

df_age<-distinct(df,age, .keep_all = T)
df_age
#just compare the rows by the values of column g, if duplicated, keep the first appearence. 

#arrange()
df_age_asce<-arrange(df,age)
df_age_asce



#Look at a larger dataset
ShelterDogs <- read_csv("/cloud/project/ShelterDogs.csv") #Source: Kaggle
head(ShelterDogs)
dim(ShelterDogs)
colnames(ShelterDogs)

#filter(): get all the dogs that are older than 1 year;
df_above1y <- filter (ShelterDogs, age >1)

#distinct()
df_name <- distinct(ShelterDogs,name, .keep_all = T)
dim(df_name)
dim(ShelterDogs)


#group_by
df_sex <- group_by(ShelterDogs, sex)
head(df_sex)

#summarise the average age of dogs
df_avg_age<-summarise(ShelterDogs, ave_age = mean(age))
df_avg_age

#if we want to summarize the average age by sex?
df_sex <- group_by(ShelterDogs, sex)
df_sex_age<-summarise(df_sex, ave_age = mean(age))
df_sex_age

#arrange()
df_age_asce <- arrange(ShelterDogs,age)
head(df_age_asce)



##Completing multiple transofrmations at a time?


##Pipe example:
library(magrittr)
library(dplyr)

pipe_old <- ShelterDogs %>%
  filter(age >1) %>% #keep only dogs older than 1 year
  distinct(name, .keep_all = T) %>% #remove dogs with the same name
  group_by(sex) %>% #group dogs by sex
  summarise(ave_age = mean(age)) #get the average age by sex

pipe_old


#the new pipe operator "|>" in R 4.1.0 in April 21
pipe_new <- ShelterDogs |>
  filter(age >1) |> #keep only dogs older than 1 year
  distinct(name, .keep_all = T) |> #remove dogs with the same name
  group_by(sex) |> #group dogs by sex
  summarise(ave_age = mean(age)) #get the average age by sex

pipe_new




##Nested