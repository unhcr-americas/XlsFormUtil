# Module UI Home

#' @title mod_home_ui and mod_home_server
#' @description A shiny module.
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal

mod_home_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "home",
		absolutePanel(  ## refers to a css class
		  id = "splash_panel", top = 0, left = 0, right = 0, bottom = 0,
		  ### Get the name for your tool
		  p(
		    tags$span("XlsForm ", style = "font-size: 60px"),
		    tags$span("Utilities", style = "font-size: 34px")
		  ),
		  br(),
		  ### Then a short explainer
		  p(paste("This ",tags$span("companion app", style = "color:#00B398"), " brings additional functions when 
		          designing questionnaire as XlsForm: 
		          1.) Estimation of Duration to avoid long interview;  
		          2.) Pretty Print in Word to faciliate peers comments; 
		          3.) systematic comparison between a contextualised version and the original template."),
		    style = "font-size: 20px; text-align: left;"),
		  br(),
		  br(),
		  p("This app is part of a ",tags$span("comprehensive app toolkit", style = "color:#00B398"),
		    " to enhance the process of survey implementation through Kobotoolbox. It includes: ",
		    tags$a(href="https://rstudio.unhcr.org/rmsSampling/", "rmsSampling"), " to help designing sampling strategies, ",
		    tags$a(href="https://rstudio.unhcr.org/Survey_Designer", "SurveyDesigner"), " to help integrating annual survey needs, ",
		    tags$a(href="https://rstudio.unhcr.org/XlsFormUtil/", "XlsFormUtil"), " to help reviewing form contextualisation, ",
		    tags$a(href="https://rstudio.unhcr.org/HighFrequencyChecks/", "HighFrequencyChecks"), " to monitor data collection quality, ",
		    tags$a(href="https://rstudio.unhcr.org/kobocruncher/", "KoboCruncher"), " to perform rapid data exploration and compile indicators.",
		    style = "font-size: 12px"),
		  p(tags$i( class = "fa fa-github"),
		    "App built with ",
		    tags$a(href="https://edouard-legoupil.github.io/graveler/",
		           "{graveler}" ),
		    " -- report ",
		    tags$a(href="https://github.com/unhcr-americas/XlsFormUtil/issues",
		           "issues here." ,
		    ),
		    style = "font-size: 10px")
		)
	)
}

# Module Server
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal

mod_home_server <- function(input, output, session) {
	ns <- session$ns
	# This create the links for the button that allow to go to the next module
	observeEvent(input$go_to_firstmod, {
	  shinydashboard::updateTabItems(
	    session = parent_session,
	    inputId = "tab_selected",
	    selected = "firstmod"
	  )
	})
}

## copy to body.R
# mod_home_ui("home_ui_1")

## copy to app_server.R
# callModule(mod_home_server, "home_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "home",icon = icon("user"))

