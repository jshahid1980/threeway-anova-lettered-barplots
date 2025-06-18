# =============================================================================
# THREE-WAY BAR PLOT WITH STATISTICAL ANALYSIS
# Description: Creates a three-way bar plot with ANOVA and Tukey's HSD for a 
#              specified dependent variable (DV) from a dataset, using standard
#              error (SE) for error bars, dynamic y-axis limits, and adaptive
#              letter placement. Prints ANOVA grand mean, CV%, summary table, 
#              and Tukey HSD critical difference.
# Author: Dr. Muhammad Jamil, Department of Botany, 
#         The Islamia University of Bahawalpur, Punjab, Pakistan
# Email: muhammadjamil@iub.edu.pk
# License: Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
# Copyright (c) 2025 Muhammad Jamil
# Dependencies: ggplot2, dplyr, multcompView
# Usage: Modify `dv` and `y_label` to analyze different dependent variables.
# =============================================================================

# ------------------------------
# SETUP AND CONFIGURATION
# ------------------------------

# Load required libraries
# Install if needed: install.packages(c("ggplot2", "dplyr", "multcompView"))
library(ggplot2)      # For plotting
library(dplyr)        # For data manipulation
library(multcompView) # For statistical significance letters

# User-configurable parameters
setwd("E:/aov")              # Set working directory (modify as needed)
data_file <- "df.csv"  # Input CSV file
dv <- "PH"          # Dependent variable (e.g., "Carotenoids", "chlA", "chlB")
y_label <- "Plant Height (cm)"  # Y-axis label for plot

# ------------------------------
# DATA INPUT
# ------------------------------

# Read data
dt <- read.csv(data_file)
# To get the column names of the data file (dt)
names(dt)

# ------------------------------
# STATISTICAL ANALYSIS
# ------------------------------

# Perform three-way ANOVA
anova_formula <- as.formula(paste(dv, "~ stress * treat * var"))
anova <- aov(anova_formula, data = dt)
print(summary(anova))

# Tukey's HSD test for pairwise comparisons
tukey <- TukeyHSD(anova)

# Generate compact letter display for significance
cld <- multcompLetters4(anova, tukey)
cld <- as.data.frame.list(cld$`stress:treat:var`)

# ------------------------------
# DATA PREPARATION
# ------------------------------

# Calculate mean and standard error for each treatment combination
dt_summary <- dt %>%
  group_by(stress, treat, var) %>%
  summarise(
    mean_val = mean(.data[[dv]], na.rm = TRUE),
    se_val = sd(.data[[dv]], na.rm = TRUE) / sqrt(n()),  # Standard error
    sample_size = n(),  # Sample size per group
    .groups = "drop"
  ) %>%
  arrange(desc(mean_val)) %>%
  mutate(Tukey = cld$Letters)  # Add significance letters

# Set dynamic y-axis limit based on mean and 2*SE with 15% buffer
y_max <- max(dt_summary$mean_val + 2 * dt_summary$se_val) * 1.15

# Print ANOVA grand mean, CV%, summary table, and Tukey HSD critical difference
print(data.frame(Grand_Mean = mean(dt[[dv]], na.rm = TRUE)))
print(data.frame(CV_Percent = (sd(residuals(anova), na.rm = TRUE) / mean(dt[[dv]], na.rm = TRUE)) * 100))
print(dt_summary)
mse <- summary(anova)[[1]]$`Mean Sq`[nrow(summary(anova)[[1]])]  # Mean square error from ANOVA
n_groups <- nrow(dt_summary)  # Number of treatment combinations
n_replicates <- mean(dt_summary$sample_size)  # Average sample size
q_crit <- qtukey(0.95, n_groups, anova$df.residual)  # Critical value for alpha = 0.05
hsd_value <- q_crit * sqrt(mse / n_replicates)  # Tukey HSD critical difference
print(data.frame(HSD_value = hsd_value))

# ------------------------------
# PLOT CREATION
# ------------------------------

# Create bar plot with ggplot2
p <- ggplot(dt_summary, aes(x = treat, y = mean_val, fill = stress)) +
  # Bar chart with dodged bars
  geom_bar(stat = "identity", position = "dodge") +
  
  # Error bars for standard error
  geom_errorbar(aes(ymax = mean_val + se_val, ymin = mean_val - se_val),
                position = position_dodge(0.9),
                width = 0.25,
                color = "Gray25") +
  
  # Significance letters above bars with dynamic offset
  geom_text(aes(label = Tukey, y = mean_val + se_val + 0.05 * y_max),
            size = 2.5,
            color = "Gray25",
            position = position_dodge(1)) +
  
  # Customize labels and scales
  labs(y = y_label) +
  ylim(0, y_max) +
  
  # Facet by var levels
  facet_grid(~factor(var, levels = c("v1", "v2"))) +
  
  # Apply clean theme
  theme_bw() +
  theme(
    axis.title.x = element_blank(),  # Remove x-axis title
    legend.position = "none",       # Remove legend
    text = element_text(size = 12),
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 10)
  )

# Display plot
print(p)

# ------------------------------
# SAVE PLOT
# ------------------------------

# Save plot as high-resolution TIFF
ggsave(
  filename = paste0(dv, "_plot.tiff"),
  plot = p,
  width = 3,
  height = 2,
  dpi = 300,
  compression = "lzw",
  bg = "white"
)

# =============================================================================
# END OF SCRIPT
# =============================================================================