install.packages("rmarkdown")
---
title: "GEOG465 - Project 1"
author: "Alexis Racioppi"
date: "1/30/2020"
output:
  html_document: default
  pdf_document: default
  md_document: markdown_github
---
  
---

## Project 1
 
```


file <- "/Users/alexibri/Desktop/GEOG456/Project1/MonaLoa.csv" #path to csv file containing the data
df <- read.csv(file) #creates database using data from the csv file
install.packages("ggplot2")
install.packages("RColorBrewer")
install.packages("ggforce")
install.packages("gganimate")
library(ggplot2)
library(RColorBrewer) #Didn't actually get to use this
library(ggforce)
library(gganimate)
# a spiraled plot of raltive CO2 change since 1958, colors according to total CO2
p <- ggplot(df, aes(x=Decimal.Date, y=InterMinDiff)) + geom_bar(stat="identity") #Creates a plot with x=decimal date and y= the difference between the current CO2 value and the first CO2 value.
p <- p + aes(fill = Interpolated.monthly.avg..ppm.CO2) #assigns the monthly CO2 averages to be coded in color on the plot
p + labs(x=NULL, y="CO2 Increase (ppm)") + scale_fill_gradient(name = "Monthly CO2 (ppm)", low = "yellow", high = "red")+coord_polar(theta="x")+ scale_x_continuous(breaks =seq(1958,2019,6))+scale_y_continuous(breaks=seq(0,110,10))
  # Erases x axis label, sets y axis labe, screates a color scale with yellow as the lowest value and red as the highest, establishes polar coordinate system, adjusts scale breaks for both variables to include more tick mark labels

#This creates circles for each observation with diameter = to relative CO2 change
Total_CO2 = df[ ,5] #Creates a list with values from the Interpolated Avg. Monthly CO2 values column in df dataframe
h <-ggplot() + xlim(0,110) + ylim(0,110) + geom_circle(aes(x0=55, y0=55, r=(df[ ,11])/2, color="orangered", fill = Total_CO2))
h + scale_x_continuous(name = "") + scale_y_continuous(name = "") #Creates a plot of circles cenetred at (55,55), with diameter = relative CO2 change, filled with totalCO2 values


#Now to create a loop of circle plots for each of the 742 observations of CO2 concentration. This plays like a weird strobe animation.
TotalCO2 = df[ ,5] #Creates a list of values using the 5th row of the dataframe df, 5th row = Total Interpolated CO2 values
CO2diff = df[ ,11] #Creates a list of values using the 11th row of the dataframe df, 11th row = CO2 difference values from original CO2 value
for (i in seq_along(CO2diff)){ #this will loop through the list created above until it exhausts the list
  CO2_Total = TotalCO2[i] #Creates a variable that is equal to the TotalCO2 list value in position i, depending on what i is in the loop iteration.
  r = CO2diff[i] #creates a variable r that is equal to the CO2diff list value in position i, depending on what i currently is in the loop iteration.
  q <- ggplot() + xlim(0,30) + ylim(0,30) + geom_circle(aes(x0=15, y0=15, r=r, color="orangered", fill = CO2_Total))
  print(q) #creates and prints a plot with grid space up to 30 for both x and y. Draws a circle on the plot centered at position (15,15) with radius = the r value estblished earlier, outlines circle in orangered color, uses CO2_Total value to fill with color.
  #To play this through the plot would need to be larger than 30x30 because later circles are too large for those dimensions.
  Sys.sleep(0.1) #creates a 0.1 second gap between this iteration and the next iteration of the for loop
}

#Here is my attempt at animation of circle plots, foiled by "Error in order(ind):argument 1 is not a vector"
#Total_CO2 = df[ ,5]
#h <-ggplot() + xlim(0,110) + ylim(0,110) + geom_circle(aes(x0=55, y0=55, r=(df[ ,11])/2, color="orangered", fill = Total_CO2))
#h + scale_x_continuous(name = "") + scale_y_continuous(name = "")
#h +transition_states(as.vector(df[ ,11]), transition_length = 2, state_length = 1)
#print(last_animation())
#anim_save(filename ="Amination2.gif", animation = p, path = "/Users/alexibri/Desktop/GEOG456/Project1")

```