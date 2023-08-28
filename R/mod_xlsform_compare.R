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
		  column(
		    width = 12,
			h2("Compare xlsform with original template"),
			p("The export from this function will help you to in order to quickly flag
			  differences between your local contextualisation and the global template."),
			br(),
			p("It is essential to follow these steps because they ensure that 
			  important variables, needed later during the data analysis by the ",
			  tags$a(href="https://rstudio.unhcr.org/RBM-indicators/",
			         "Indicator Calculation Automation Scripts"),
			  br(),
			  ", are not overlooked. A frequent problem, for example, involves confusion 
			  regarding the encoding of choice variable names, which are actually
			  represented using numerical codes. ",
			br(),
			"It's important to note that this comparison is carried out solely for a 
			specific predefined language")
		  )
		) ,
		fluidRow(

		shinydashboard::box(
		  title = "Set up Comparison",
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
      		  inputId =  ns("xlsformbase"),
      		  label = "Upload a valid xlsform to be used as comparison basis (.xlsx file)",
      		  accept = ".xlsx"  )
		      ),

		    column(
		      width = 6,
		      downloadButton(outputId = ns("compare"),
    		              label = "Export an excel with a complete comparison",
    		              width =  "200px")
		    )
		  )
		)
		)
	)
}

#' Module Server
#' @noRd
#' @import shiny
#' @import tidyverse
#' @importFrom stringr str_remove str_to_lower str_replace_all  regex
#' @importFrom  fs path_file
#' @keywords internal

mod_xlsform_compare_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
	
	## Define plot on observe input$xlsform
	observeEvent(input$xlsformbase,{
	  req(input$xlsformbase)
	  message("Please upload a file")
	  AppReactiveValue$xlsformbasepath <- input$xlsformbase$datapath
	  #browser()
	  
	  ## get also filename in a clean way
	  AppReactiveValue$xlsformbasefilename <-  
	    stringr::str_to_lower(
	      stringr::str_replace_all(
	        stringr::str_remove(
	          input$xlsformbase$name,
	          ".xlsx"),
	        stringr::regex("[^a-zA-Z0-9]"), "_")) 
	  
	  ## change file  in the server to the correct name
	  file.rename(AppReactiveValue$xlsformbasepath, # from
	              
	              paste0( dirname(AppReactiveValue$xlsformbasepath) , 
	                      "/",
	              AppReactiveValue$xlsformbasefilename,
	              ".xlsx")
	              ## to
	              )
	  
	  AppReactiveValue$xlsformbasepath <-  paste0( dirname(AppReactiveValue$xlsformbasepath) , 
	                                               "/",
	                                               AppReactiveValue$xlsformbasefilename,
	                                               ".xlsx")
	  
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
	
	
	
	output$compare <- downloadHandler( 
	  filename = function(){
	    paste( 'xlsform_comparison_from', 
	           AppReactiveValue$xlsformbasefilename, 
	           '_to_',
	           AppReactiveValue$xlsformfilename, 
	           '.xlsx')
	  },
	  content = function(file){
	    fct_xlsform_compare(listfile = c(AppReactiveValue$xlsformbasepath, 
	                                     AppReactiveValue$xlsformpath),
	                         label_language = AppReactiveValue$language,
	                         fileout = file)
	                         }
    	)
	  
	  
	#   filename = "xlsform_comparion.xlsx",
	#   content = function(file) {
	#     tempReport <- file.path(tempdir(), "xlsform_comparion.xlsx")
	#     fct_xlsform_compare(listfile = c(AppReactiveValue$xlsformbasepath, 
	#                                      AppReactiveValue$xlsformpath),
	#                         label_language = AppReactiveValue$language,
	#                         fileout = file)
	#     
	#     id <- showNotification(
	#       "Working on it...",
	#       duration = NULL,
	#       closeButton = FALSE
	#     )
	#     on.exit(removeNotification(id), add = TRUE)
	#   }
	# )
	
	

}

## copy to body.R
# mod_xlsform_compare_ui("xlsform_compare_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "xlsform_compare",icon = icon("user"))

## and copy to app_server.R
# callModule(mod_xlsform_compare_server, "xlsform_compare_ui_1")

