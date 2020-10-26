# ui.R

library(shiny)
library(shinythemes)
shinyUI(fluidPage( 
  shinythemes::themeSelector(),
  titlePanel("Body Fat Calculator for Male"),
  sidebarLayout(sidebarPanel(numericInput("age", label = "Age (years)", value = 45),
                             numericInput("weight", label = "Weight (lbs)", value = 177.3),
                             numericInput("height", label = "Height (inches)", value = 70.3),
                             numericInput("neck", label = "Neck Circumference (cm)", value = 38),
                             numericInput("chest", label = "Chest Circumference (cm)", value = 100.4),
                             numericInput("abdomen", label = "Abdomen 2 Circumference (cm)", value = 92),
                             numericInput("forearm", label = "Forearm Circumference (cm)", value = 28.6),
                             numericInput("wrist", label = "Wrist Circumference (cm)", value = 18.2),
                             submitButton("Calculate!"),
                             tags$hr(), 
                             p("The measurement standards of this calculator refers to Behnke and Wilmore's work", 
                               em("Evaluation and Regulation of Body Build and Composition(1974) pp. 45-48."),
                               " Alternatively, we find this ", 
                               a("Measurement Guide",
                                 href = "https://static1.squarespace.com/static/58c1609febbd1a9d3cd78dc0/t/59edf14fe9bfdff9af4505fd/1508766037975/MEASUREMENTS-GUIDE.pdf"),
                               " on the internet, the reference photos in it may be helpful."
                               ),
                             br(),
                             p("For your convenience, convert centimeter to inch, kilogram to pound and vice versa by using this",
                               a("Unit Converter.", 
                                 href = "https://www.unitconverters.net"))
                             ),
                mainPanel(
                  h2(textOutput("bdfat_text")),
                  h2(textOutput("percentage")),
                  h5(textOutput("error_text")),
                  plotOutput("plot"),
                  uiOutput("git"),
                  h5(textOutput("group")),
                  h5(textOutput("contact"))
                )
                )
  )
)