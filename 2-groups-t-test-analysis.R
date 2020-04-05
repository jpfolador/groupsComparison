#-----------------------------------------------
# Comparison between the ages of two groups
#
# Author: Joao Paulo Folador
# email: jpfolador at gmail.com
#-----------------------------------------------

if (!require("tidyr")) { install.packages('tidyr') }
if (!require("irr")) { install.packages('irr') }
if (!require('blandr')) { install.packages('blandr') }

if (!require("ggplot2")) { install.packages("ggplot2") }
if (!require("ggthemes")) { install.packages("ggthemes") }
if (!require("cowplot")) { install.packages("cowplot") }
if (!require("extrafont")) { install.packages("extrafont") }
if (!require("RColorBrewer")) { install.packages("RColorBrewer") }

# Load Windows fonts
loadfonts(device = "win")

# setup the theme to ggplot
theme_set(theme_bw())

# load the file with the data
participants <- read.csv(file = 'participants-sample.csv', header = TRUE, sep = ";")

h <- participants[which(participants$volunteer == 'h'), ]
pd <- participants[which(participants$volunteer == 'pd'), ]

summary(h$age)
h.shap = shapiro.test(h$age)

summary(pd$age)
pd.shap = shapiro.test(pd$age)

# Site of color pallet: http://paletton.com/
axisTextColor <- "#555555";
barContourColor <- "#9D5F44";
barFillColor <- "#EAEAEA"
lineColor <- "#FF9366";
pointColor <- "#8C3E00";

histh <- ggplot(data=h, aes(h$age)) + 
           geom_histogram(aes(y =..density..), color = barContourColor, alpha = 0.8, 
                          bins = 20, fill=barFillColor, size=1) + 
           stat_function(fun = dnorm, geom = "line", color = lineColor, size = 1.2, na.rm = TRUE,
                         args = list(mean = mean(h$age), sd = sd(h$age))) +
           labs(x = 'Age (years)', y = 'Density', subtitle = paste("A", '- Histogram of healthy group')) +
           theme(text = element_text(size=22,  family="serif", color=axisTextColor),
                 axis.text.x = element_text(size=24, color=axisTextColor),
                 axis.text.y = element_text(size=24, color=axisTextColor),
                 plot.margin = unit(c(0.4, 0.4, 0.4, 0.4), "cm"),
                 plot.title = element_text(size = 20, color=axisTextColor))

addTextH <- paste("W: ", round(h.shap[["statistic"]][["W"]], 4), "| p:", 
                  round(h.shap[["p.value"]], 4))

qqh <- ggplot(h, aes(sample = h$age)) +
        stat_qq(color = pointColor, size=2) +
        stat_qq_line(color = lineColor, size=1) + 
        labs(x = 'Theoretical', y = 'Samples', subtitle = paste("B", '- QQ-Plot of healthy group')) +
        theme(text = element_text(size=22,  family="serif", color=axisTextColor),
              axis.text.x = element_text(size=24, color=axisTextColor),
              axis.text.y = element_text(size=24, color=axisTextColor),
              plot.margin = unit(c(0.4, 0.4, 0.4, 0.4), "cm"),
              plot.title = element_text(size = 20, color=axisTextColor)) +
        annotate("text", x = -2, y = 82, size=6,  family="serif", color=axisTextColor,
                 label = as.character(as.expression(addTextH)), hjust=0,
                 parse = FALSE)
        
histPd <- ggplot(data=pd, aes(pd$age)) + 
            geom_histogram(aes(y =..density..), color = barContourColor, alpha = 0.8, 
                           bins = 20, fill=barFillColor, size=1) + 
            stat_function(fun = dnorm, geom = "line", color = lineColor, size = 1.2, na.rm = TRUE,
                          args = list(mean = mean(pd$age), sd = sd(pd$age))) +
            labs(x = 'Age (years)', y = 'Density', subtitle = paste("C", '- Histogram of PD group')) +
            theme(text = element_text(size=22,  family="serif", color=axisTextColor),
                  axis.text.x = element_text(size=24, color=axisTextColor),
                  axis.text.y = element_text(size=24, color=axisTextColor), 
                  plot.margin = unit(c(0.4, 0.4, 0.4, 0.4), "cm"),
                  plot.title = element_text(size = 20, color=axisTextColor))

addTextPd <- paste("W: ", round(pd.shap[["statistic"]][["W"]], 4), "| p:", 
                   round(pd.shap[["p.value"]], 4))

qqPd <- ggplot(pd, aes(sample = pd$age)) +
          stat_qq(color = pointColor, size=2) +
          stat_qq_line(color = lineColor, size=1) + 
          labs(x = 'Theoretical', y = 'Samples', subtitle = paste("D", '- QQ-Plot of PD group')) +
          theme(text = element_text(size=22,  family="serif", color=axisTextColor),
                axis.text.x = element_text(size=24, color=axisTextColor),
                axis.text.y = element_text(size=24, color=axisTextColor),
                plot.margin = unit(c(0.4, 0.4, 0.4, 0.4), "cm"),
                plot.title = element_text(size = 20, color=axisTextColor)) +
        annotate("text", x = -2, y = 82, size=6,  family="serif", color=axisTextColor,
                 label = as.character(as.expression(addTextPd)), hjust=0,
                 parse = FALSE)

plot_grid(histh, qqh, histPd, qqPd, nrow=2, ncol=2)


#---------------------------------------------------------------
#   If the data has a normal distribution then apply t.test   
#---------------------------------------------------------------
t.test(pd$age, h$age)
