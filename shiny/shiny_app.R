library(shiny)
library(tidyverse)

library(readxl)
datas <- read_excel("datas.xlsx")


ui <- fluidPage(textInput(inputId = "Company",
                          label = "Company",
                          value = "",
                          placeholder = "Apple"),
              
                selectInput(inputId = "Cores",
                            label = "Cores",
                            choices = list( "8","6","4","2","1")),
                sliderInput(inputId = "Viti",
                            label ="Year Range:",
                            min = min(datas$Viti),
                            max = max(datas$Viti),
                            value = c(min(datas$Viti),
                                      max(datas$Viti)),
                            sep= ""),
                submitButton("Create plot!"),
                plotOutput(outputId = "plot"),
               
)
server <- function(input , output){
  output$plot <- renderPlot(
    datas %>%
      filter( Cores == input$Cores,
              Company == input$Company) %>%
      ggplot(aes( x= Viti,
                  y = Shitjet)) +
      geom_line() +
     scale_x_continuous(limits = input$Viti)+
      theme_minimal()
    
  )
}
shinyApp(ui = ui, server = server)