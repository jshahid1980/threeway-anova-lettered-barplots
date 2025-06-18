# threeway-anova-lettered-barplots
This R-code is written for absolute beginners who are using RStudio for the first time and have no prior knowledge of the R language. It creates a three-way bar plot with ANOVA and Tukey's HSD for a specified dependent variable (DV) from a dataset, using standard  error (SE) for error bars, dynamic y-axis limits, and adaptive  letter placement. Prints ANOVA grand mean, CV%, summary table, and Tukey HSD critical difference. A data file "df.csv" is given to practise the code. 

# Getting Started with RStudio: Step-by-Step Instructions
Run this line of code only for one time if packages have not been installed: 
install.packages(c("ggplot2", "dplyr", "multcompView"))
Follow these simple steps to run the 3-way anova and bar plot script using RStudio:
i. Make sure both 3wayBarPlot_df.R (the R script) and df.csv (your data file) are saved in a folder named aov on the E: drive of your computer.
ii. Launch RStudio: Go to File > Open File. Navigate to: Computer > E: > aov > 3wayBarPlot_df.R
iii. Click Open > Run the Script
iv. Once the script is open in RStudio, press Ctrl + A to select all the code > Click Run to execute the script.

# Usage of this R-code for your own data
Your data file must be in .csv format (like an Excel sheet saved as .csv). The file should be named "df.csv". The structure of your data (column names and layout) should match the example file "df.csv" included with this folder. The script "3wayBarPlot_df.R" as explained earlier; go to line 30 in the script: change the variable name there to the one you want to analyze from your own data. Then go to line 31: change the label (in quotes) to what you want to appear on the Y-axis, including the unit (e.g., "Plant Height (cm)"). 
# The example data file uses three grouping factors: 
“treat” for x-axis, "stress" as bar-color and "var" as panel. 
i. Your data may have different three factors
ii. Open the script file, use Ctrl + F (Find) to search for the words: stress, treat, and var.
iii. Replace each one with the names of the three factors in your own data, aiming which one you want to take on x-axis, which should be appeared as bar-colors etc.
# Important Note for the Last Factor: “var” in the example:
It is used to split the plot into groups (called facets). Go to line 114 in the code, and update it based on the levels (categories) of your last factor which you want to use to split the graphs into panels according to the categories of your last factor. For example, if your last factor has levels like "Hybrid1" and "Hybrid2", you should adjust line 114 accordingly.
 
## 📜 License
This project is licensed under the **Creative Commons Attribution–NonCommercial 4.0 International License (CC BY-NC 4.0)**.

You are free to:
- **Share** — copy and redistribute the material in any medium or format
- **Adapt** — remix, transform, and build upon the material

Under the following terms:
- **Attribution** — You must give appropriate credit to the author:
  > Muhammad Jamil, Department of Botany, The Islamia University of Bahawalpur, Pakistan.
   
  > Cite this repository when using the code or data.
- **NonCommercial** — You may **not** use this material for commercial purposes.
📄 View full license: [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)
