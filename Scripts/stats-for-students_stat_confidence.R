# Libraries ####
library(ggplot2)
library(extrafont)
library(xkcd)
library(mgcv)

# Set seed to ensure reproducible results
set.seed(1)

# Preparing data ####
stat_confidence <- read.csv("./Data/stat_confidence_coordinates.csv")

xrange <- c(0,800)
yrange <- c(0,500)

# Marking important time points ####
first_stats_class <- 100
stats_final_exam <- 320
project_requiring_stats <- 500
stats_for_students_start <- 620
    
# Interpolating data for unified smooth ####

# Changing the linetype partway through means that a seperate smooth is used for each segment
# Causes undesirable discontinuity
# Solution: smooth first manually, then plot the predicted smooth

# Smoothing parameter manually selected to acheive desired look
smoothed_fit <- loess(Stats~Time, data=stat_confidence, span=0.3)


# Generating interpolated points
n_interpolation_points <- 600
prediction_points <- seq(from = xrange[1], to = xrange[2], length.out = n_interpolation_points)
predicted_points <- predict(smoothed_fit, prediction_points)

interpolated_stat_confidence <- data.frame(Time=prediction_points, Stats=predicted_points)

# Marking whether points were before or after starting with Stats for Students
interpolated_stat_confidence$Before <- ifelse(interpolated_stat_confidence$Time < stats_for_students_start, TRUE, FALSE)

# Checking smooth appearance
ggplot(data=interpolated_stat_confidence, aes(x=Time, y=Stats)) + geom_line()


# Producing the graph ####
stat_confidence_plot <- ggplot(data=interpolated_stat_confidence, aes(x=Time, y=Stats)) + 
    geom_line(colour="black", size=1.5, aes(linetype=Before)) + 
    scale_linetype_manual(values=c(2,1)) + 
    theme(text = element_text(size = 12, family = "xkcd")) +
    guides(linetype=FALSE) +
    xkcdaxis(xrange, yrange) + 
    xlab("Time") +
    ylab("Your statistics knowledge") +
    theme(axis.ticks = element_blank(), axis.text = element_blank()) +
    # Annotations
    annotate("text", x=first_stats_class, y = 350, family="xkcd", size=3,
             label = "First Statistics\nClass") +
    annotate("text", x=stats_final_exam, y = 300, family="xkcd", size=3,
             label = "Stats Exam") +
    annotate("text", x=project_requiring_stats, y = 400, family="xkcd", size=3,
             label = "Stats-Heavy\nProject") +
    annotate("text", x=stats_for_students_start, y = 300, family="xkcd", size=3,
             label = "Stats for Students\nIntervention")
    
# Showing graph
print(stat_confidence_plot)

# Saving the graph
# .png, .svg and .pdf
ggsave("./Figures/stat_confidence_plot.png", stat_confidence_plot, width=6, height=4, units="in")
ggsave("./Figures/stat_confidence_plot.svg", stat_confidence_plot, width=6, height=4, units="in")
ggsave("./Figures/stat_confidence_plot.pdf", stat_confidence_plot, width=6, height=4, units="in")