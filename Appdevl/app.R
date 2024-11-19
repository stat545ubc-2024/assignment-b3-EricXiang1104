
# Assignment B3. Crea ting a Shiny App
#Eric Xiang
#2024 11.21
#The goal of this app is to plot histogram for the mean variables in the cancer_sample dataset, 
#It will also filter out the variable it is plotting and then rearrange the dataset based on the variable of interest, ID and diagnosis status. 
#It utilizes the cancer_data from the datateachr package
#The app contains three features 1. Generating the histogram with different colors 2. Generating an interactive table including the selected variables.
#3.An option to sort the table based on the selected variable of interest and download the table if interested. It will also report the row number of the table. 

#Installation code, not needed if installed
#install.packages("colourpicker")#install if needed
#install.packages('rsconnect')#install if needed 

library(shiny)# import shiny app for app creation 
library(tidyverse)#import tidyverse for data analysis 
library(datateachr) # import datateachr for the data file
library(dplyr)#dplyr package is for data analysis 
library(colourpicker)#import colourpicker for changing color of the graph 
library(DT)#for generating an interactive table 

library(rsconnect)# for publishing the web 
#publish the web
#rsconnect::deployApp("C:/Users/Eric Xiang/Desktop/assignment-b3-EricXiang1104/Appdevl")

data("cancer_sample")#cancer_sample from the dataset is used for the web development


# Define UI for application. Allow user to define colors for histogram. The feature is set up for aesthetic purpose but is also useful for colorblind users
#an cancer cell image is added for aesthetic purpose
ui <- fluidPage(
  titlePanel("Cancer Sample  Mean Data"),
  checkboxInput("variableSort","sort by variable",TRUE),
  colourInput("col", "Select colour", "purple"),
  sidebarLayout(
    sidebarPanel(
    selectInput("variableInput","Variable",
               choices=c("radius_mean","texture_mean","perimeter_mean","smoothness_mean","compactness_mean","concavity_mean"),
               selected="radius_mean"),
    downloadButton("downloadData", "Download Table as CSV")),
    mainPanel(img(src='cancer.jpg',align = "centre",height='400px',width='400px'),plotOutput("coolplot"),strong(textOutput("numRows")),DTOutput('tb1'),
              )
    )
  )

# Define server logic required 
server <- function(input, output,session) {
#Feature 1: Select the data based on the user variable selection
#if desired, will rearrange the table based on the variable selected. The feature is useful for generating an organized table downstream    
   filtered <-reactive({
    new_data<-cancer_sample %>%
    select(ID,diagnosis,input$variableInput)  
    if (input$variableSort){
      new_data<-new_data %>% arrange(!!sym(input$variableInput))}
    return(new_data) })
#Feature 2: To draw a histogram for the selected variable to visually understand the distribution of the variable 
  output$coolplot <- renderPlot({
    ggplot(cancer_sample, aes_string(input$variableInput)) +
      geom_histogram(bins = 30 , fill=input$col)+
      labs(title=paste("Histogram of",input$variableInput),x=input$variableInput,y="Count")

  })
#Part of Feature1: Generate a table output. The table is interactive with DT package, making it useful to search up the data
  
  output$tb1 = renderDT( datatable(
    filtered(), options = list(lengthChange = FALSE)))
  
#Part of Feature3; Generate the Row number output for the table. Useful to understand how large the dataset is
  output$numRows <- renderText({
    paste("Number of rows in the table:", nrow(filtered()))
})

#Feature 3: download table  output as a CSV file useful for future analysis by users
  output$downloadData<-downloadHandler(
    filename=function(){
      paste("cancer_table.csv" )},
    content=function(file){
      write.csv(filtered (),file)
}
  )

}


# Run the application 
shinyApp(ui = ui, server = server)



      