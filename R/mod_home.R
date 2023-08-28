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
		  p("This app brings additional capacities when designing XlsForm questionnaires in the context of Household Surveys: ",
		    style = "font-size: 22px"),
		  hr(),
		  p("1.) Ensure a systematic comparison between a contextualised version and the global standard template for the form. This is key to avoid breaking up indicator calculation script!",
		    style = "font-size: 18px"),
		  hr(),
		  p(" 2.) Estimate the duration to avoid long interview according to different parameters.",
		style = "font-size: 18px"),
		hr(),
	  	p(" 3.) Generate a Pretty Print in Word to facilitate the recollection of peers comments within the operation using tracking mode. 
	  	  This is to avoid a situation where 2 versions of the from are managed in parallel (i.e. the word one is generated from the xlsform file).",
		    style = "font-size: 18px"),
		hr(),
		  br(),
		  br(),
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

