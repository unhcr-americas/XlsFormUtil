#' Module UI
 
#' @title mod_upload_form_ui and mod_upload_form_server
#' @description A shiny module.
#' @description A shiny module.
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#' @import shiny 
#' @import shinydashboard 
#' @keywords internal
 
mod_upload_form_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "upload_form",
		fluidRow(
		  column(
		    width = 12,
		    h2('Your XlsForm'),
		    p("You are reaching this app because, you have already a valid xlsform."),
		    p("Note that the app doe not include any xlsform validation capacity"),
		    p("Use Kobotoolbox builtin xlsform validator before, or alternatives such as ",
		      tags$a(href="https://opendatakit.org/xlsform/",
		             "ODK validator"), 
		      ". You may also check some ",
		      tags$a(href="https://unhcr.github.io/Integrated-framework-household-survey/Configure-forms.html",
		             "Tips here. ") ),
		      br()
		   )
		),
		fluidRow(
		    shinydashboard::box(
		      title = "Upload and Set Language",
		      #  status = "primary",
		      status = "info",
		      solidHeader = FALSE,
		      collapsible = TRUE,
		      #background = "light-blue",
		      width = 12,
		      fluidRow(
		  
      		  fileInput(
      		    inputId =  ns("xlsform"),
      		    label = "Upload a valid XlsForm (.xlsx file)",
      		    accept = ".xlsx",
      		    width =  "500px"),
      		  
      		  selectInput(inputId = ns("language"),
      		              label = "  Select Language to use",
      		              choices = list("Default as specified in xlsform" = NULL,
      		                             "English (en)" = "English (en)",
      		                             "Spanish (es)" = "Spanish (es)",
      		                             "French (fr)" = "French (fr)" ,
      		                             "Arabic (ar)" = "Arabic (ar)",
      		                             "Portuguese (pt)"= "Portuguese (pt)"),
      		              selected = NULL,
      		              width = '400px'),
      		  p( "Language to be used in case you have more than one.
                        If not specified, the 'default_language' in the 'settings' worksheet is used.
                        If that is not specified and more than one language is in the XlsForm,
                        the language that comes first within column order will be used.
            		        Please, comply with the language codebook from",
      		     tags$a(href="http://www.iana.org/assignments/language-subtag-registry/language-subtag-registry",
      		            "Internet Assigned Numbers Authority (IANA)"),
      		     style = "font-size: 12px") ,
      		  hr()
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
 
mod_upload_form_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
	
	
	observeEvent(input$language, {
	  AppReactiveValue$language <- input$language
	})
	
	
	## Define plot on observe input$xlsform
	observeEvent(input$xlsform,{
	  req(input$xlsform)
	  message("Please upload a file")
	  AppReactiveValue$xlsformpath <- input$xlsform$datapath
	  #browser()
	  updateSelectInput(
	      session = session,
	      inputId = "language",
	      choices =  fct_xlsfrom_language( xlsformpath = AppReactiveValue$xlsformpath  )
	    )
	})
	
	
}
 
## copy to body.R
# mod_upload_form_ui("upload_form_ui_1")
 
## copy to sidebar.R
# menuItem("displayName",tabName = "upload_form",icon = icon("highlighter))
 
## and copy to app_server.R
# callModule(mod_upload_form_server, "upload_form_ui_1", AppReactiveValue)
 
