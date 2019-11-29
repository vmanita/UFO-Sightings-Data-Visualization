require(shiny)
require(leaflet)
require(htmltools)
require(ggplot2)
library(highcharter)
library(billboarder)
library(lubridate)
library(tidyverse)
#library(usmap)
library(maps)
library(ggiraph)

#ticks <- c(1950, 2000, 2014)

# example_tiles <- plot_usmap(regions = "states")

#monthly$yrmon <- as.yearmon(monthly$yrmon, "%y%m")


#as.Date(monthly$yrmon, "%Y-%m")
# theme paper/cosmo/cyborg



title <- tags$a(href = 'https://www.youtube.com/watch?v=HQoRXhS7vlU',
                tags$img(src='alien_PNG18.png',height='50',width='50'),
                'UFO Sightings',style = "font-family: 'helvetica', cursive;font-weight: 1000; line-height: 1.1;color: #FFFFFF;")
                
css_codes <- tags$style(type = "text/css",".irs-bar {background: lime; border-top: 1px lime; border-bottom: 1px lime;}
                           .irs-bar-edge {background: lime; border: 1px lime; width: 20px;}
                        .irs-line {border: 1px lime;}
                        .irs-from, .irs-to, .irs-single {background: rgba(100, 100, 100, 0)}
                        .irs-grid-text {color: white; font-weight: bold;}
                        .label-default {background: lime;}
                        .irs-slider to {background: url('alien_PNG18.png') no-repeat;}
                        .irs-slider from {background: url('alien_PNG18.png') no-repeat;}
                        .irs-slider single {background: url('alien_PNG18.png') no-repeat;}
                        }
                        ")

css_panels <- tags$style(HTML(".tabbable > .nav > li[class=active]    > a {background-color: green; color:white}"))

css_slider_back <- tags$head(tags$style(HTML('
                                             #sidebar {
                                             background-color: rgba(100, 100, 100, 0);
                                             }')))

css_checkbox <- tags$head(tags$style(HTML('
                                          #checkbox section.sidebar .shiny-input-container:checked{
                                          background-color: lime;
                                          }')))

ui <- fluidPage(theme = shinytheme("cyborg"),
  css_codes, css_slider_back, css_checkbox, css_panels,
  ## TITLE
  #setBackgroundImage(src = "http://hdqwalls.com/wallpapers/orion-nebula-4k-qk.jpg"),
  setBackgroundImage(src = "space_background_darker.png"),
  titlePanel(h1(title)),
  
  
  tabsetPanel(
    ## HOME -------------------------------------------------------
    tabPanel("Home",
             sidebarLayout(position = 'right', 
                           sidebarPanel(id = "sidebar",
                             h2(div(HTML('<p align = "center"; style = "position:relative;top;15px;color:coral"><b>We are not alone</b></p>'))),
                             p(div(HTML("<p align = 'justify'; style='color:white; font-size: 15px;'>Brace yourselves for an Intergallactic exploration of planet Earth visitors.
                                Ever since 1914 that there are records of udentifyed flying objects sighted in the sky.
                                In the following pages we will focus our attention to sightings that took place in the United States, 
                                the country with the most registered sightings in the entire world, and show you in detail how these
                                visits are characterized</p>")),
                               br(),
                             img(src='mulder.png', height = 250, width = 360))),
                           mainPanel(leafletOutput("home", height = 600,width=800))
             )
    ),
    
    ## LINEPLOT -------------------------------------------------------
    tabPanel('Sightings per year', sidebarLayout(
      ## 3
      sidebarPanel(h3(HTML('<p align = "center"; style="color:coral"><b>Increasing Earth tourism</b></p>')),br(),
        ##6
        sliderTextInput("line_input",
                    HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Choose year range:</p>'),
                    to_min = 1950,
                    to_max = 2014,
                    selected = c(1950,2014),
                    choices = seq(1950,2014, 1), grid = TRUE),
        helpText(HTML('<p align = "justify"; style="color:white">
                      In this chart we can observe how the number of UFO sightings increases over the years.
                      In 1993, the number starts to increase until it peaks in 2012, where 6252 UFOs were spotted.
                      Then, untill 2014, the number of sightings has a decrease of 69% when compared to 2012, where 1931 UFOs were spotted.
                      </p>
                      <p align = "center"; style="color:white; font-weight: bold; font-size: 20px;">World Events</p>
                      </p>
                      
                      <p align = "left"; style="color:coral; font-size: 15px">
                      <b>1978 - Arcades</b></p>
                      <p align = "justify"; style="color:white">
                      <i>Space Invaders, created by Tomohiro Nishikado, revolutionized
                      the video game industry.</i></p>

                      <p align = "left"; style="color:coral; font-size: 15px">
                      <b>1933 - X - Files</b></p>
                      <p align = "justify"; style="color:white">
                      <i>The show X-Files premiered on the Fox Network in September. It was declared a "cultural" touchstone of the 1990s.</i></p>
                      
                      <p align = "left"; style="color:coral; font-size: 15px">
                      <b>2012 - End of the World</b></p>
                      <p align = "justify"; style="color:white">
                      <i>According to eschatological beliefs, a set of cataclysmic events would set to occour on 21 of December 2012, that would lead to the end of the world.</i></p>
                      
                      <p align = "left"; style="color:coral; font-size: 15px">
                      <b>2015 - California, Nevada</b></p>
                      <p align = "justify"; style="color:white">
                      <i>Thousands of onlookers across three states saw a streak of light leaving a 
                        green trail. The US Navy says it was an unarmed missile test.</i></p>'))),
      ## 4
      mainPanel(highchartOutput("line_plot", width = 630))
      
      
      )),
    ## WORLD -------------------------------------------------------
    tabPanel("Sightings per state", 
             sidebarPanel(h3(HTML('<p align = "center"; style="color:coral"><b>Where are they seen?</b></p>')),br(),class = "panel panel-default",
                           sliderTextInput("cartoon_slider",
                                       HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Choose Year:</p>'),
                                       to_min = 1950,
                                       to_max = 2014,
                                       selected = 1990,
                                       grid = TRUE,
                                       choices = seq(1950,2014, 1),animate=animationOptions(interval=300, loop=FALSE,
                                        playButton = actionButton("action", label = HTML('&#9658'), style = "color:lime; position:relative;top:15px;"),
                                        pauseButton = actionButton("action", label = HTML('| |'), style = "color:lime; position:relative;top:15px;")))
                            
                          
                           
           ),leafletOutput("cartoon", height = 500, width = 800)),

    ## BARPLOT -------------------------------------------------------
    tabPanel('Sightings per shape',  
             sidebarPanel(h3(HTML('<p align = "center"; style="color:coral"><b>Is it a plane?</b></p>')),br(),
              materialSwitch("checkbox", label = HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Cumulative Years</p>'), value = TRUE),
              tags$head(tags$style("#checkbox{ color: lime; position:right;top:15px;}"
              )),
               hr(),
               fluidRow(column(3, verbatimTextOutput("value"))),
               # years
               sliderTextInput("year", HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Select Year:</p>'),
                           to_min = 1950,
                           to_max = 2014,
                           grid = TRUE,
                           selected = 1950,
                           choices = seq(1950,2014,1)),
               selectInput("state_input",HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Select State:</p>'),unique_states, selected = 'All States')
               # checkbox
             ),mainPanel(highchartOutput("ufoBar")  
             )
    ),
  ## HEAT -------------------------------------------------------
  tabPanel('Sightings by Time',
           sidebarLayout(
             sidebarPanel(h3(HTML('<p align = "center"; style="color:coral"><b>Interstellar Rush Hours</b></p>')),br(),
                          selectInput("x_input", HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Select X Axis:</p>'),c('month','dayofweek','day','hour','minute'), selected = 'month'),
                          selectInput("y_input",HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Select Y Axis:</p>'),c('month','dayofweek','day','hour','minute'), selected = 'dayofweek'),
               helpText(HTML('<p align = "justify"; style="color:white">
                              Regarding the time these undentyfied flying objects spotted, we can observe a higher frequency on summer, from <b>June</b> to <b>September</b>.
                              If we dive into a deeper granularity, a higher frequency of sightings is also noticable on <b>Saturday</b> and <b>Friday</b> night, from <b>7pm</b> to <b>11pm</b>.
                             </p>'))
             ),
             mainPanel(plotOutput("heatmap"))
           )),
  
  ## LOLLIPOP -------------------------------------------------------
  tabPanel('Sightings duration',
           sidebarPanel(h3(HTML('<p align = "center"; style="color:coral"><b>Faster than the speed of light</b></p>')),br(),
             sliderTextInput("lolli_year", HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Select Year Range:</p>'),
                         to_min = 1951,
                         to_max = 2014,
                         grid = TRUE,
                         selected = 2003,
                         choices = seq(1951,2014,1)),
             sliderTextInput("duration", HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Select Duration Range:</p>'), to_min = 0, 
                         to_max = 500, selected = c(50, 500), grid = TRUE, choices= seq(0,500,1)),
             helpText(HTML('<p align = "justify"; style="color:white">
                            Each one of the sightings has a duration, presented here in minutes, that ranges from a single glimpse to testimonials of individuals who claim to have seen an UFO for three months straight.
                            After removing some outliers, almost every US state shortest sighting was of almost 0 seconds, while the longest ones were on <b>Tennessee</b> and <b>Oregon</b> in 2011 with observations of about <b>8 hours</b> straight.
                           </p>'))
           ),mainPanel(ggiraphOutput("ufoLolli"),height = 1000)
           ),
  ## WORDCLOUD -------------------------------------------------------
  tabPanel("Comments Analysis", sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(h3(HTML('<p align = "center"; style="color:coral"><b>"It was bright and red!"</b></p>')),br(),
      sliderTextInput("freq",
                      HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Select Minimum Word Frequency:</p>'),
                      choices = freqlist, selected = 15, grid = TRUE, to_min = 10),
      sliderTextInput("max",
                      HTML('<p style="color:white; font-weight: bold; font-size: 15px;">Select Maximum Number of Words:</p>'),
                      choices = wordlist, selected = 300, to_min = 1),
      helpText(HTML('<p align = "justify"; style="color:white">
                  Upon sighting an UFO, the report of the individual is complete by adding a commentary about what they observed.
                  For analysis purposes, we provide a wordcloud that reflects the most common words used on the observer testimonial.</p>')), width = 4),
    
    # Show Word Cloud
    mainPanel(
      plotOutput("plot", width = 1000, height = 1000)
    )
  )))
)
#*********************************************************

server <- function(input,output, session){
  lang <- getOption("highcharter.lang")
  lang$decimalPoint <- ","
  lang$numericSymbols <- highcharter::JS("null")
  options(highcharter.lang = lang)
  observe({
  
  ## LINE -------------------------------------------------------

    
    sights <- sights[which(sights$year==input$line_input[1]): which(sights$year==input$line_input[2]),]
    
    output$line_plot <- renderHighchart({
      highchart() %>%
        hc_add_series(data= sights$n_ufos, name= 'No. of sightings', 
                      color='lime', showInLegend=FALSE, type = "line") %>%
        hc_legend(enable=FALSE) %>%
        hc_title(text='')%>%
        hc_xAxis(categories =sights$year, title = list(text= ''),
                 labels = list(style = list(color = "white", fontSize = '14px',fontWeight = "bold")))%>%
        hc_yAxis(gridLineWidth= 0,min = 0,title = list(text= 'No. of sightings', style = list(color = 'white')),
                  labels = list(style = list(color = "white", fontSize = '14px',fontWeight = "bold")))
   
    })
  })
 
  ## WORDCLOUD  -------------------------------------------------------
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$plot <- renderPlot({
    set.seed(1234)
    wordcloud_rep(words = d$word, freq = d$freq, min.freq = input$freq,
                  max.words=input$max, random.order=FALSE, rot.per=0.35, colors=c("#edf8fb",
                                                                                  "#b2e2e2",
                                                                                  "#66c2a4",
                                                                                  "#238b45"),
                  scale=c(5,1))
  }, height = 600, width = 600, bg = 'black')
  
  ## 3RD TAB / HOME -------------------------------------------------------
  
  #home.df <- ufo[ufo$shape %in% c("light","triangle","fireball","circle","disk"),]
  home.df<-ufo[(ufo$year >=2010),]
  
  output$home <- renderLeaflet({
    
    leaflet(home.df) %>%
      addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
      setView(
        lng = -98.327818,
        lat = 38.642763,
        zoom = 4
      )%>%
      addCircleMarkers(~longitude,~latitude,
                       stroke=FALSE,color='lime',
                       radius = 1)
  })
  
  
  ## BAR -------------------------------------------------------
  observe({
      
   if (input$checkbox == TRUE){
     if (input$state_input == 'All States'){
       by_shape <- ufo[ufo$year<=input$year,] %>%
         group_by(shape) %>%
         summarise(Total = n()) %>%
         arrange(desc(Total))
       by_shape<-na.omit(by_shape)
     }
     else {
       by_shape <- ufo[(ufo$year<=input$year) & (ufo$state_long == input$state_input),] %>%
         group_by(shape) %>%
         summarise(Total = n()) %>%
         arrange(desc(Total))
       by_shape<-na.omit(by_shape)
     }
   }
  else{
    if (input$state_input == 'All States'){
      by_shape <- ufo[ufo$year==input$year,] %>%
        group_by(shape) %>%
        summarise(Total = n()) %>%
        arrange(desc(Total))
      by_shape<-na.omit(by_shape)
    }
    else {
      by_shape <- ufo[(ufo$year==input$year) & (ufo$state_long == input$state_input),] %>%
        group_by(shape) %>%
        summarise(Total = n()) %>%
        arrange(desc(Total))
      by_shape<-na.omit(by_shape)
    }
  }
    
    output$ufoBar <- renderHighchart({
      
      # max
      max_freq = max(by_shape$Total)
      
      # here i am defining the barplot
      highchart() %>% 
        hc_chart(type = "column", style = list(fontweight = "bold")) %>% 
        hc_xAxis(categories = by_shape$shape, labels = list(style = list(color = "white", fontSize = '14px',fontWeight = "bold"))) %>% 
        hc_yAxis(gridLineWidth= 0,lineColor = 'white', lineWidth = 1,
                 labels = list(style = list(color = "white",fontSize = '12px',fontWeight = "bold")),
                 title = list(text= 'No. of sightings', style = list(color = 'white'))) %>%
        hc_legend(enable=FALSE) %>%
        hc_add_series(data = by_shape$Total,
                      name = "No. sightings", showInLegend = FALSE,color='lime',borderWidth = 0,pointWidth = 25)
    })
  })
  
  
  ## WORLD -------------------------------------------------------
  
  ufoIcon <- makeIcon(
    iconUrl = "www/marker.png",
    iconWidth = 15,
    iconHeight = 15
  ) 
  
  
  output$cartoon <- renderLeaflet({
    
    leaflet() %>%
      # here is where tiles providers lie
      
      #OSM
      #Toner
      #addTiles(group = "OSM") %>%
      addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
      setView(
        lng = -98.327818,
        lat = 38.642763,
        zoom = 4
      ) %>%
      
      
      addLayersControl(
        
        options = layersControlOptions(collapsed = FALSE)
      )
    
    
  })
  
  observe({
    
    d <- mapa_state[mapa_state$year >= input$cartoon_slider[1] & mapa_state$year <= input$cartoon_slider[1], ]
    
    d <- aggregate(n_ufos~ state_long, d, sum)
    
    d <- merge(d, long, by = c('state_long'))
    d <- merge(d, lat, by = c('state_long'))
    
    
    leafletProxy("cartoon", data = d ) %>%
      clearMarkers()%>%
      addCircleMarkers(~longitude,~latitude, 
                       
                       label = mapply(function(n_ufos, state_long) {
                         HTML(sprintf("<h0>Nro. of Sightings:</h0> <b>%s</b><p><h0>State: </h0><b>%s</b>" , 
                                      htmlEscape(n_ufos), htmlEscape(state_long)))},
                         d$n_ufos, d$state_long, SIMPLIFY = FALSE),
                       
                       options= markerOptions(title=d$state_long, draggable = TRUE),
                       radius = (d$n_ufos/10),
                       stroke=FALSE,color='lime', 
                       fillOpacity = 0.7,
                       labelOptions = labelOptions(
                         style= list("color"="black", 
                                     'font-size'='15px',
                                     "border-color"='black'))
      )
  
  
  })
  
  ## HEATMAP -------------------------------------------------------
  
  observe({
    x <- as.character(input$x_input)
    y <- as.character(input$y_input)
    or <- aggregate(ufo[,x], by= list(ufo[,x],ufo[,y]), FUN= length)
    names(or) <- c("col1", "col2", "count")
    
    output$heatmap <- renderPlot({
      or %>% filter() %>%
        ##########
      ggplot(aes(x= factor(col1), y= factor(col2))) +
        ##########
      geom_tile(aes(fill = count)) +
        scale_x_discrete("", expand = c(0,0)) +
        scale_y_discrete("y axis", expand = c(0,-2))  +
        scale_fill_gradient(guide='colourbar',low='#32CD32', high='#006400', aesthetics = c("colour","fill")) +
        theme_minimal() + ggtitle("UFO HEATMAP") +
        theme(panel.grid.major = element_line(colour = NA), panel.grid.minor = element_line
              (colour = NA)) + theme(
                axis.text.x = element_text(face="bold",size=14,angle=60, hjust=1,colour="white"),
                axis.text.y = element_text(face="bold",size=14,colour="white"),
                legend.text=element_text(face="bold",color='white',size=12),
                strip.text = element_text(size=11))
    },bg = 'transparent')
  })
  
  ## LOLLIPOP -------------------------------------------------------
  observe({
    
    by_duration <- new_ufo[(new_ufo$year==input$lolli_year) & (new_ufo$minute_duration>=input$duration[1] & new_ufo$minute_duration<=input$duration[2]),] %>%
      group_by(new_state)%>%
      summarise(minimo = min(minute_duration), maximo = max(minute_duration))%>%
      na.omit(by_duration)%>%
      arrange(maximo) %>%
      mutate(new_state=factor(new_state, levels=new_state))
    
    output$ufoLolli <-  renderggiraph({
      lolli <- ggplot(by_duration, aes(x = new_state, y = minute_duration))  +
        geom_segment( aes(x=new_state, xend=new_state, y=minimo, yend=maximo), color="grey") +
        geom_point_interactive( aes(x=new_state, y=minimo, tooltip = minimo, color='coral'), size=2.5) +
        geom_point_interactive( aes(x=new_state, y=maximo, tooltip = maximo, color='Green'), size=2.5) +
        scale_x_discrete(expand=c(0.01,0)) +
        scale_color_manual(name = NULL, labels = c("Shortest UFO Sighting","Longest UFO Sighting"), values = c("coral","Green"))+
        theme_light() + 
        theme(legend.position = c(0.85,0.2),
              panel.background = element_rect(fill = "transparent"),
              plot.background = element_rect(fill = "transparent", color = NA),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              legend.background = element_rect(fill = "transparent"),
              legend.box.background = element_rect(fill = "transparent"),
              axis.title.x = element_text(colour = "white"),
              axis.title.y = element_text(colour = "white"),
              axis.text.x = element_text(colour="white"),
              axis.text.y = element_text(colour="white"),
              legend.key = element_rect(fill = "transparent"),
              legend.text = element_text(colour="white",face="bold"),
              panel.border = element_blank(),
              axis.line.x = element_line(colour = "white"), 
              axis.line.y = element_line(colour = "white")) +
        xlab("States") +
        ylab("Duration (in minutes)") + coord_flip() 
      girafe(ggobj = lolli)
      
    }) 
  })
}


shinyApp(ui = ui, server = server)
