#Plotting Time-series
##Example Data: FedFundRate.csv
library(tidyverse)
library(readr)
library(lubridate)
library(ggplot2)

FedFundsRate <- read_csv("_data/FedFundsRate.csv")

#creating a date column
FedFundsRate_date <- FedFundsRate |>
  mutate(date = str_c(Year, Month, Day, sep = "-"))

FedFundsRate_date <- FedFundsRate_date|>
  relocate(date, .before = Year)

head(FedFundsRate_date) #for sanity check

#Create a date column
FedFundsRate_date <- FedFundsRate_date|> 
  mutate(ymd(date))

##Plotting the federal funds target rate (Y) over year (X)
FedFund_Year_point<-ggplot(FedFundsRate_date, aes(x=Year, y=`Federal Funds Target Rate`))+
  lims(x=c(1980, 2010), y = c(0, 12))+
  geom_point()+
  stat_smooth()

FedFund_Year_point

FedFund_Year_line<-ggplot(FedFundsRate_date, aes(x=Year, y=`Federal Funds Target Rate`))+
  lims(x=c(1980, 2010), y = c(0, 12))+
  geom_line()

FedFund_Year_line

#plotting over date(X)
##Make sure we force the date column to be recognized as a Date/Time class object: use as.Date()
#option 1
FedFundsRate_date$date <- as.Date(FedFundsRate_date$date) 

#plotting
FedFund_date_point<-ggplot(FedFundsRate_date, aes(x= date, y=`Federal Funds Target Rate`))+
  geom_point()+
  stat_smooth()

FedFund_date_point

FedFund_date_line<-ggplot(FedFundsRate_date, aes(x=date, y=`Federal Funds Target Rate`))+
  geom_line()

FedFund_date_line

#option 2
FedFund_date_point<-ggplot(FedFundsRate_date, aes(x = as.Date(date,"%Y-%m-%d"), y =`Federal Funds Target Rate`))+
  geom_point()+
  stat_smooth()
FedFund_date_point


FedFund_date_line<-ggplot(FedFundsRate_date, aes(x = as.Date(date,"%Y-%m-%d"), y =`Federal Funds Target Rate`))+
  geom_line()
FedFund_date_line


##we can even change the scale of date/time:= use scale_x_date(limits, date_breaks)


FedFund_date_line<-ggplot(FedFundsRate_date, aes(x = date, y =`Federal Funds Target Rate`))+
  geom_line()+
  scale_x_date(limits = as.Date(c("1983-06-01","1985-06-01")), date_breaks = "1 month",
               date_labels = "%B") 

FedFund_date_line

FedFund_date_line<-ggplot(FedFundsRate_date, aes(x = date, y =`Federal Funds Target Rate`))+
  geom_line()+
  scale_x_date(limits = as.Date(c("1982-06-01","1983-06-01")), date_breaks = "1 week",
               date_labels = "%U") 

FedFund_date_line

FedFund_date_line<-ggplot(FedFundsRate_date, aes(x = date, y =`Federal Funds Target Rate`))+
  geom_line()+
  scale_x_date(limits = as.Date(c("1983-01-01","1990-01-01")), date_breaks = "1 year",
               date_labels = "%Y") 

FedFund_date_line

#%Y: year; %B month; "%U": week number; %D: day of the month; 

#changing the axis text layout: theme() and the angle option --> will be covered more in Week#9 

FedFund_date_line<-ggplot(FedFundsRate_date, aes(x = date, y =`Federal Funds Target Rate`))+
  geom_line()+
  scale_x_date(limits = as.Date(c("1983-06-01","1985-06-01")), date_breaks = "1 month",
               date_labels = "%B") +
  theme(axis.text.x=element_text(angle=60, hjust=1))

FedFund_date_line

##Plotting multiple variables of economic data;
##most straight-foward method: two geom_line() functions
FedFund_date_line<-ggplot(FedFundsRate_date, aes(x = date))+
  geom_line(aes(y = `Federal Funds Target Rate`, color ="darkred"))+
  geom_line(aes(y = `Inflation Rate`, color="steelblue"))+
  scale_x_date(limits = as.Date(c("1983-06-01","1985-06-01")), date_breaks = "1 month",
               date_labels = "%B") +
  theme(axis.text.x=element_text(angle=60, hjust=1))

FedFund_date_line



##Plotly Example:
library(plotly)

library(hrbrthemes)

# Load dataset from github
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered.csv", header=T)
data$date <- as.Date(data$date)

# Usual area chart
p <- data |>
  ggplot( aes(x=date, y=value)) +
  geom_area(fill="#69b3a2", alpha=0.5) +
  geom_line(color="#69b3a2") +
  ylab("bitcoin price ($)") +
  theme_ipsum()

# Turn it interactive with ggplotly
p <- ggplotly(p)
p


##Animated line
library(ggplot2)
library(gganimate)
library(hrbrthemes)
library(gifski)
#
FedFundsRate_animated<-ggplot(FedFundsRate_date, aes(x=date, y=`Federal Funds Target Rate`)) +
  geom_line() +
  geom_point() +
  scale_x_date(limits = as.Date(c("1983-01-01","1990-12-01")), date_breaks = "1 month",
               date_labels = "%B") +
  theme_ipsum() +
  theme(axis.text.x=element_text(angle=60, hjust=1))+
  transition_reveal(date)


animate(FedFundsRate_animated, duration = 20, fps = 10, width = 500, height = 500, renderer = gifski_renderer())

anim_save("FedFundsRate.gif")




#Spatial Visualization
##Spatial Points
#let's take a look at what spatial data looks like first:
library(sp)

x_coords <- runif(n = 100, min = -100, max = -80)
y_coords <- runif(n = 100, min = 25, max = 45)

# Have a look at the first coordinates
head(spatial_points<-cbind(x_coords,y_coords))


#create a coordinate column
firstPoints <- SpatialPoints(coords = cbind(x_coords,y_coords))
head(firstPoints)

plot(firstPoints, pch = 19)

##take another example:
#ColeraDeath Case Distribution of the 1854 Broad Street cholera outbreak. (by John Snow)

library(mdsr)
library(sf)
head(CholeraDeaths)
CholeraDeaths<-CholeraDeaths

##drawing the points
ggplot(CholeraDeaths) +
  geom_sf()



#example form the reading:
library(maps)
us_states <- map_data("state")
head(us_states)

##the has more than 15,000 rows because you need a lot of lines to draw a good-looking map
p <- ggplot(data = us_states,
            mapping = aes(x = long, y = lat,
                          group = group))

p + geom_polygon(fill = "white", color = "black")

#notice: what's wrong with this US Map? What is/are missing?
