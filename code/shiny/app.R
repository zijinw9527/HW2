# app.R

library(shiny)
library(shinythemes)
library(ggplot2)

# ui

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

# server

bdfat <- function(ab, we, wr, h, ag, c, n, f) {
  bf = 174.9061 - 1.3484*ab + 1.1144*we - 5.5715*wr - 0.4743*h - 0.9374*ag - 0.1550*c - 5.1855*n + 0.3360*f - 0.0048*ab*we + 0.0809*wr*ag + 0.0834*ab*n - 0.0052*ab*ag - 0.0159*we*n
  return(round(bf, 3))
}

server <- function(input, output) {
  #setwd("/Users/oujieri/Desktop/STAT628/2Body_Fat_Project/HW2/code/shiny")
  
  body_fat = reactive({
    ab = as.numeric(input$abdomen)
    we = as.numeric(input$weight)
    wr = as.numeric(input$wrist)
    h = as.numeric(input$height)
    ag = as.numeric(input$age)
    c = as.numeric(input$chest)
    n = as.numeric(input$neck)
    f = as.numeric(input$forearm)
    return(bdfat(ab, we, wr, h, ag, c, n, f))
  })
  
  output$bdfat_text = renderText({
    if(body_fat() > 0 & body_fat() < 100) {
      text = paste("The percentage of your body fat is: ")
    } else {
      text = paste("Something went wrong when we try to calculate your body fat percentage :( Please double check your input.")
    }
    return(text)
  })
  
  output$percentage = renderText({
    if(body_fat() > 0 & body_fat() < 100) {
      pct = paste(body_fat(), "%")
    } else {
      pct = paste("NA")
    }
    return(pct)
  })
  
  data = read.csv("./cleandata.csv")
  Range = data.frame(xmin = c(0, 6, 14, 18, 25), 
                     xmax = c(6, 14, 18, 25, 50),
                     ymin = -Inf, ymax = Inf,
                     Region= c("Essential fat 2%-5%", "Athletes 6%-13%", "Fitness 14%-17%", "Average 18%-25%","Obese 25%+"))
  
  output$plot = renderPlot({
    if (body_fat()<100 & body_fat()>0){
      ggplot(data, aes(x = BODYFAT)) + geom_density(size = 0.5, linetype = "dotdash") +
        ggtitle("Density Plot of the Body Fat Percentage") +
        xlab("Body Fat Percentages") + ylab("Desity")+ geom_vline(xintercept = body_fat(),linetype = "dashed",color="midnightblue", size=2) + 
        geom_rect(data = Range, inherit.aes=F, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=Region)) + 
        scale_fill_manual("Legend", breaks = Range$Region, values = adjustcolor(c("mediumspringgreen","mediumpurple2","chartreuse2","steelblue2","orangered1"),alpha.f = 0.3)) +
        annotate(geom="text",fontface="italic", x = (body_fat()-6), y =  0.03, label = as.character(paste0("You are here!")),size = 6,color ="midnightblue") +
        theme_light() + theme(legend.position = c(0.85, 0.8))
    }else{
      NULL
    }
  })
  
  output$error_text = renderText({
    if (body_fat()>100 | body_fat()<0){
      "Something went wrong when we try to calculate your body fat percentage :( Please double check your input."
    }else{ 
      NULL
    }
  })
  
  gitlink <- a("Body Fat Project", href="https://github.com/zijinw9527/STAT628_ModuleTwo20")
  output$git <- renderUI({
    tagList("We'd be honor if you are interested in our work. The whole project including the data processing, modeling  and model selection has been uploaded to github. Your suggestions are welcome :", gitlink)
  })
  
  output$group = renderText("Designed by Daiyi Shi, Haoran Teng and Zijin Wang.")
  
  output$contact = renderText("Feel free to contact us if you come across any problems while using. Email: zwang2548@wisc.edu")
}


shinyApp(ui = ui, server = server)