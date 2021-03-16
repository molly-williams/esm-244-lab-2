library(shiny)
library(tidyverse)
library(shinythemes)
library(RColorBrewer)

# Get the data! (in this type of script, everything without a # reads as code)

marvel <- read_csv("marvel-wikia-data.csv")

marvel$SEX[is.na(marvel$SEX)] <- "Not Specified"


# Create user interface (always called ui)

ui <- fluidPage(
    
    
    theme = shinytheme("slate"),
    titlePanel("Marvel Characters"),
    sidebarLayout(
        sidebarPanel(
            radioButtons("side",
                         "Choose a side",
                         c("Good Characters",
                           "Bad Characters",
                           "Neutral Characters"))
        ),
        
        mainPanel(
            
            plotOutput(outputId = "marvelplot")
        
        )
    )
    
    
    
)

# Server is the brains of the operation

server <- function(input, output) {
    
    output$marvelplot <- renderPlot({
        
        ggplot(filter(marvel, ALIGN == input$side), aes(x = Year)) +
            geom_bar(aes(fill = SEX), position = "fill") +
            theme_dark()
        
    })
    
}


# Run the application 
shinyApp(ui = ui, server = server)
