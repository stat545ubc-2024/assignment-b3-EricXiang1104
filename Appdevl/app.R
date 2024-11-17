
# Assignment B3. Crea ting a Shiny App
#install.packages("colourpicker")#install if needed

library(shiny)
library(tidyverse)
library(datateachr) 
library(dplyr)
library(colourpicker)


data("cancer_sample")#cancer_sample from the dataset is used for the web development 

# Define UI for application 
ui <- fluidPage(
  titlePanel("Cancer Sample  Data"),
  checkboxInput("variableSort","sort by variable",TRUE),
  colourInput("col", "Select colour", "purple"),
  sidebarLayout(
    sidebarPanel(
    selectInput("variableInput","Variable",
               choices=c("radius_mean","texture_mean","perimeter_mean"),
               selected="radius_mean"),
    downloadButton("downloadData", "Download Table as CSV")),
    mainPanel(img(src='cancer.jpg',align = "centre",height='400px',width='400px'),plotOutput("coolplot"),strong(textOutput("numRows")),tableOutput("results")
              )
    )
  )

# Define server logic required 
server <- function(input, output,session) {
#Select the data based on the user variable selection, if desired, will rearrange the table based on the variable selected.    
   filtered <-reactive({
    new_data<-cancer_sample %>%
    select(ID,diagnosis,input$variableInput)  
    if (input$variableSort){
      new_data<-new_data %>% arrange(!!sym(input$variableInput))}
    return(new_data) })
#To draw a histogram 
  output$coolplot <- renderPlot({
    ggplot(cancer_sample, aes_string(input$variableInput)) +
      geom_histogram(binwidth = 1, fill=input$col)+
      labs(title=paste("Histogram of",input$variableInput),x=input$variableInput,y="Count")

  })
#table output
  output$results <- renderTable({filtered()
  })
#Row number output
  output$numRows <- renderText({
    paste("Number of rows in the table:", nrow(filtered()))
})

#download table  output
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
      