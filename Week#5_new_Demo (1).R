##Relational Data and Joins
#Using the flights data
library(lubridate)
library(nycflights13)

#load the five data
flights<-flights

airlines<-airlines

airports<-airports

planes<-planes

weather<-weather

#unique primary key; look for the entry/observation
#larger than 1
tailnum<-planes |> 
  count(tailnum) |> 
  filter(n > 1)
tailnum
#multiple primary keys

weather |> 
  count(year, month, day, hour, origin) |> 
  filter(n > 1)


##Mutating joins
#create a new data
flights2 <- flights |> 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

#Joins the airline data by "carrier"
flights2 |>
  #select(-origin, -dest) |> 
  left_join(airlines, by = "carrier") 











##Functions:

##writing a function to estimate all summary statistics
## add another example change the original data after running the function()

sum_stat <- function(x){
  stat <- tibble(
    mean=mean(x,na.rm=T),
    median=median(x,na.rm=T),
    sd=sd(x,na.rm=T)
  )
  return(stat)
}

sum_stat(flights$arr_delay)#I don't need to do summarise() for each of the column!



#or alternatively, baseR function: summary()
summary(flights$dep_delay)



##Strings()


##Descriptive String Functions
fruits <- c("one apple", "two pears", "three bananas", "four apples")

#str_length
str_length(fruits) 
##noted that space count as an number of element in length

#str_detect
str_detect(fruits, "apple")

str_detect(fruits, "appleone")

str_detect(fruits, "a")

#str_count
str_count(fruits, "apple")

str_count(fruits, "one apple")

str_count(fruits, "a")

##It is case sensitive
##It is space sensitive
##It is order senstivie

##Extact Match Functions
#str_c
subject<-("I have ")
sentence<-str_c(subject, fruits)
print(sentence)

sentence<-str_c("Buy ", fruits)
print(sentence)

#str_subset and str_extract
str_subset(fruits, "a") 

str_subset(fruits, "^o") #starts with o

str_subset(fruits, "s$") #ends with s


str_extract(fruits, "^o")

str_extract_all(fruits, "a")
typeof(a)
# notice how it differ from subset#it only extract the specific letter in the specific location

##str_replace()
fruits <- c("one apple", "two pears", "three bananas")
str_replace_all(fruits, "[aeiou]", "1")

#"[aeiou]" is a regular expression pattern enclosed in square brackets. 
#This pattern matches any lowercase vowel character (a, e, i, o, or u). 
#square brackets are used to define character classes.

#"-" is the replacement string. Any matching character should
#be replaced with a hyphen ("-")


