# **Assignment B3 Shiny App Development**

This assignment is creating a web using shiny app. The goal of this app is to plot a histogram for the mean variables in the cancer_sample dataset (specifically, radius_mean", "texture_mean", "perimeter_mean","smoothness_mean","compactness_mean","concavity_mean). It will also filter out the variable it is plotting and then rearrange the dataset based on the variable of interest. The app utilizes the cancer_data from the datateachr package

The data cancer_sample is from datateachr package, an open source data for education purpose.This cancer_data contains a sample of quantitative features that were calculated from images of nuclei present in fine needle aspiration biopsies of breast masses from patients at the University of Wisconsin Hospital. For this assignment, I am focusing on the mean data.

The app contains **three features** 1. Generating the histogram with different colors to help visualize the distribution. A histogram can help visualize the distribution of the variable. Different colors is for aesthetic purposes. An image of the cancer cell is added to make the web look pretty (from PharmaTimes online). 2. Generating an interactive table including the selected variables so the user can search up the data they are interested in the dataset. 3.An option to sort the table based on the selected variable of interest and download the table if interested. It will also report the row number of the table. This is to help users clean up the table and save the table for future analysis if needed

**Link to the running app:** <https://ericxiang.shinyapps.io/CancerSampleMean4/>
