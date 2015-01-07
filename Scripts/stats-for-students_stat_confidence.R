# Libraries ####
library(ggplot2)
library(extrafont)
library(xkcd)

# Preparing data ####
stat_confidence <- read.csv("./Data/stat_confidence_coordinates.csv")

xrange <- range(stat_confidence$Time)
yrange <- range(stat_confidence$Stats)

# Producing the graph ####
ggplot(data=stat_confidence, aes(x=Time, y=Stats)) + geom_smooth(alpha=0, colour="black", size=2) +
    theme(text = element_text(size = 16, family = "xkcd")) +
    xkcdaxis(xrange, yrange) + 
    xlab("Time") +
    ylab("Your statistics knowledge") +
    theme(axis.ticks = element_blank(), axis.text = element_blank())
    