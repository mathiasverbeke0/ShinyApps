library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Temperature Converter"),
  sidebarLayout(
    sidebarPanel(
      selectInput("unit", "Select unit to convert from:", 
                  choices = c("Celsius", "Fahrenheit"), selected = "Celsius"),
      numericInput("value", "Enter the value to convert:", 0),
      br(),
      h4("Result:"),
      textOutput("result")
    ),
    mainPanel(
      plotOutput("tempPlot")
    )
  )
)

# Define server
server <- function(input, output) {
  
  # Convert temperature
  converted_temp <- reactive({
    if (input$unit == "Celsius") {
      (input$value * 1.8) + 32
    } else {
      (input$value - 32) / 1.8
    }
  })
  
  # Output result
  output$result <- renderText({
      paste(round(converted_temp(), 2), ifelse(input$unit == "Celsius", "°F", "°C"))
  })
}

# Run the application
shinyApp(ui = ui, server = server)