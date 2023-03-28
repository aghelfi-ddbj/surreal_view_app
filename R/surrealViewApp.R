suppressMessages({
  require("DT", quietly = TRUE)
  require("shinydashboard", quietly = TRUE)
  require("shiny", quietly = TRUE)
})

dataset <- c("Project", "BioSample", "Accession", "Taxon", "DRR")
load(file = "../data/tables.rda")


sidebar <- dashboardSidebar(
  
  sidebarMenu(id="tabs",
              menuItem("View", tabName="view", icon=icon("table"), selected=TRUE),
              menuItem("About", tabName="about", icon=icon("question"))
  ),
  hr(),
  conditionalPanel("input.tabs == 'view'",
                   fluidRow(
                     column(1),
                     column(10,
                            selectInput("querytype", "Query type", dataset, selected = "Product"),
                            conditionalPanel("input.querytype", 
                                             selectizeInput("inputquery", "Query ID", 
                                                            choices = "NULL", options = list(maxOptions = 50), multiple = FALSE)),
                            hr(),
                            h5("Download Data"),
                            downloadButton('download1', 'Download')
                     )
                   )
  )
)

body <- dashboardBody(
  tabItem(tabName = "view",
          box(width = NULL, status = "primary", solidHeader = TRUE, title="Trad",
              br(),
              DT::dataTableOutput("table_view")
          )
  ),
  tabItem(tabName = "view2",
          box(width = NULL, status = "primary", solidHeader = TRUE, title="Trace",
              br(),
              DT::dataTableOutput("table_view2")
          )
  )
  
)

ui <- dashboardPage(
  dashboardHeader (title = "Surreal Viewer"),
  sidebar,
  body 
)

server <- function(input, output, session) {
  observe({
    query_level <- input$querytype
    if(query_level == "DRR"){
      query <-  unique(sort(trace[,query_level]))
    } else {
      query <-  unique(sort(trad[,query_level]))
    }
    stillSelected <- isolate(input$inputquery[input$inputquery %in% query])
    updateSelectizeInput(session, "inputquery", choices = query,
                         selected = stillSelected, server = TRUE)
  })
  
  output$table_view <- DT::renderDataTable({
    if(input$querytype == "Accession"){
      outtable <- trad[trad$Accession == input$inputquery,]
    }else if(input$querytype == "Project"){
      outtable <- trad[trad$Project == input$inputquery,]
    }else if(input$querytype == "BioSample"){
      outtable <- trad[trad$BioSample == input$inputquery,]
    }else if(input$querytype == "Taxon"){
      outtable <- trad[trad$Taxon == input$inputquery,]
    } else {
      outtable <- data.frame(Query=as.character("No result matched your search"), Output=as.numeric(0))
    }
    DT::datatable(outtable, options = list(searching = TRUE, paging = TRUE), selection = "single", rownames = FALSE)
  })
  
  output$table_view2 <- DT::renderDataTable({
    if(input$querytype == "Project"){
      outtable2 <- trace[trace$Project == input$inputquery,]
    }else if(input$querytype == "BioSample"){
      outtable2 <- trace[trace$BioSample == input$inputquery,]
    }else if(input$querytype == "Taxon"){
      outtable2 <- trace[trace$Taxon == input$inputquery,]
    }else if(input$querytype == "DRR"){
      outtable2 <- trace[trace$DRR == input$inputquery,]
      outtable2 <- outtable2[!is.na(outtable2$DRR),]
    }else {
      outtable2 <- data.frame(Query=as.character("No result matched your search"), Output=as.numeric(0))
    }
    DT::datatable(outtable2, options = list(searching = TRUE, paging = TRUE), selection = "single", rownames = FALSE)
  })
  
}

shiny::shinyApp(ui = ui, server = server)
