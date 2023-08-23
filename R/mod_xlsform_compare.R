# Module UI

#' @title mod_xlsform_compare_ui and mod_xlsform_compare_server
#' @description A shiny module.
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import shiny
#' @import shinydashboard
#' @keywords internal

mod_xlsform_compare_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "xlsform_compare",
		fluidRow(
			h2("Compare xlsform with original template"),
			p("The export from this function will help you to in order to quickly flag
			  differences between your local contextualisation and the global template."),
			br(),
			p("Going through this steps is crucial as it will help to prevent missing out
			  important variables,
			  that will be required later at the data analysis stage by the ",
			  tags$a(href="https://rstudio.unhcr.org/RBM-indicators/",
			         "Indicator Calculation Automation Scripts. "),
			  br(),
			  "A common issue for instance is messing the encoding of choices variable
			  name that are actually encoded through numbers",
			  "Note that comparison is done only for one defied selected language")
		),

		shinydashboard::box(
		  title = "Get Comparison",
		  #  status = "primary",
		  status = "info",
		  solidHeader = FALSE,
		  collapsible = TRUE,
		  #background = "light-blue",
		  width = 12,
		  fluidRow(
		    column(
		      width = 6,
      		fileInput(
      		  inputId =  "xlsformbase",
      		  label = "Upload a valid xlsform to be used as comparison basis (.xlsx file)",
      		  accept = ".xlsx"  )
		      ),

		    column(
		      width = 6,
		      downloadButton(outputId = ns("compare"),
    		              label = "Export an excel with a complete comparison",
    		              width =  "200px",
    		              style = "visibility: hidden;"),
		      actionButton( inputId =  ns("prettyprintact"),
		                    label = "Export an excel with a complete comparison",
		                    class = "btn-success" ,
		                    icon = shiny::icon("share-from-square"))
		    )
		  )
		)
	)
}

#' Module Server
#' @noRd
#' @import shiny
#' @import tidyverse
#' @keywords internal

mod_xlsform_compare_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
	
	## Define plot on observe input$xlsform
	observeEvent(input$xlsformbase,{
	  req(input$xlsformbase)
	  message("Please upload a file")
	  AppReactiveValue$xlsformbasepath <- input$xlsformbase$datapath
	  #browser()
	})

	# output$compare <- downloadHandler(
	#   
	#   req( AppReactiveValue$xlsformbasepath),
	#   message("Please upload a template form to compare with"),
	# 
	#   filename = function() {
	#     paste("_",
	#           format(Sys.time(), "%Y_%m_%d_%H_%M_%S"),  '.xlsx', sep='')  },
	#   content = function(con) {
	#     fct_xlsform_compare(listfile = c(AppReactiveValue$xlsformbasepath, AppReactiveValue$xlsformpath),
	#                         folder = "temp" ,
	#                         label_language = AppReactiveValue$language,
	#                         fileout = NULL)
	#   }
	# )
	
	
	
	output$prettyprint <- downloadHandler(
	  # For PDF output, change this to "report.pdf"
	  filename = "xlsform_comparion.xlsx",
	  content = function(file) {
	    
	    fct_xlsform_compare(listfile = c(AppReactiveValue$xlsformbasepath, 
	                                     AppReactiveValue$xlsformpath),
	                        folder = tempdir() ,
	                        label_language = AppReactiveValue$language,
	                        fileout = NULL)
	    
	    id <- showNotification(
	      "Rendering report...", 
	      duration = NULL, 
	      closeButton = FALSE
	    )
	    on.exit(removeNotification(id), add = TRUE)
	    

	  }
	)
	
	

}

## copy to body.R
# mod_xlsform_compare_ui("xlsform_compare_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "xlsform_compare",icon = icon("user"))

## and copy to app_server.R
# callModule(mod_xlsform_compare_server, "xlsform_compare_ui_1")

