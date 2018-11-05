#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(tidytext)
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Refugees"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput(inputId = "bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     destination <- read_csv("data/refugees-destination-05-15.csv")
     
     destination %>%
     select(arrivals, year, dest_state) %>% 
     filter(dest_state %in% c("California","Texas","New York","Florida","Pennsylvania")) %>% 
     ggplot(aes(x=year, y=arrivals, group = dest_state, color = dest_state)) + geom_jitter() 
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

