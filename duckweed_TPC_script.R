# Duckweed thermal response: growth rates in constant temperatures

### Packages
library(Rmisc)
library(Hmisc)
library(ggplot2)
library(reshape)
library(cowplot)
library(dplyr)
library(tidyr)
library(AICcmodavg)
library(multcomp)
library(lme4)

### Data source:
# Armitage, D. W., & Jones, S. E. (2019). Negative frequency-dependent growth 
# underlies the stable coexistence of two cosmopolitan aquatic plants. 
# Ecology, 100(5). doi:10.1002/ecy.2657

### Read data
temp_mono <- read.csv("C:/Users/user/Desktop/DuckweedCoexistence/temp_mono_growrates.csv")
temp_mono$dayf <- factor(temp_mono$day)

### Fit reaction norms model to duckweed growth rates
temp_mono_final <- subset(temp_mono, day == "28")
temp_mono_final <- subset(temp_mono_final, species == "Lemna")

LEMI_growmod <- nls(data = subset(temp_mono_final, species == "Lemna"),
                    formula = r~pmax(0,c*temp*(temp-Tmin)*(Tmax-temp)), 
                    algorithm = "port",
                    start = list(Tmax = 40, Tmin = 5, c = 0.02), lower = c(0,0,0))

### Plot the resulting thermal growth rates
cols <- c("#43a2ca","#f03b20")

tempnorm <- ggplot(temp_mono_final, aes(x = temp, y = r, fill = species , 
                                        shape = species, color = species)) +
  geom_jitter(color = "black", alpha = 0.5, size = 3, width = 1,height = 0, 
              stroke = 1) + 
  geom_smooth(method = "nls", se = FALSE, fullrange = T, lwd = 1.25,
              method.args = list(formula = y~pmax(0,c*x*(x-xmin)*(xmax-x)), 
                                 start = list(xmax = 40, xmin = 5, c = 0.2))) +
  geom_hline(yintercept = 0, lty = "dotted") + 
  scale_color_manual(values = cols) + scale_fill_manual(values = cols) +
  scale_shape_manual(values = c(21,23)) + xlim(0,45) + ylim(-.01,.2) +
  xlab("temperature") + ylab("Daily relative growth rate (r)")

plot(tempnorm)