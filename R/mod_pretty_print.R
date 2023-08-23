# Module UI

#' @title mod_pretty_print_ui and mod_pretty_print_server
#' @description A shiny module.
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import shiny
#' @import shinydashboard
#' @keywords internal

mod_pretty_print_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "pretty_print",
		fluidRow(
		  h2("Generate a Word version of your XlsForm"),
		p("When customizing and adjusting a household survey questionnaire during
		the design phase, it's often necessary to have one testing version
		(i.e. encoded in xlsform) and a more legible version in word that can be
		then shared with non-technical experts for them to comment and review."),

		p("Moving between a paper version and an encoded-machine ready version is not smooth.
		  Instead of having the master version in word and updating once while the
		  xlsform, it's more convenient to generate a word output to collect feedback
		  in word tracking mode."),
		br(),

		p("Note that for better legibility of the document, it is advised to encode the select
 question that comes with a very long list of possible answers - typically something like
 \"what is your country of origin?\" -  as",
		  tags$a(href="https://xlsform.org/en/#multiple-choice-from-file",
             "\'select_from_file\'") ),

    p(""),

		shinydashboard::box(
		  title = "Get Estimate",
		  #  status = "primary",
		  status = "info",
		  solidHeader = FALSE,
		  collapsible = TRUE,
		  #background = "light-blue",
		  width = 12,
		  fluidRow(
		    column(
		      width = 6,
		     		checkboxInput(inputId = ns("logic"),
        		              label   = "Add info on skip logic and constraints?",
        		              value   = TRUE),
        		checkboxInput(inputId = ns("duration"),
        		              label   = "Insert the duration chart within export",
        		              value   = FALSE)
		      ),

      		column(
      		  width = 6,
      		  downloadButton(outputId = ns("prettyprint"),
      		               label = "Export a word version from your xlsform",
      		               width =  "300px") #,
      		  # actionButton( inputId =  ns("prettyprintact"),
      		  #               label = "Export a word version from your xlsform",
      		  #               class = "btn-success" ,
      		  #               icon = shiny::icon("share-from-square")),
      		  #              style = "visibility: hidden;"
      		  
      		  
      		  
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
#' @keywords internal

mod_pretty_print_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns

	output$prettyprint <- downloadHandler(
	  # For PDF output, change this to "report.pdf"
	  filename = "form_for_peer_review.docx",
	  content = function(file) {
	    # Copy the report file to a temporary directory before processing it, in
	    # case we don't have write permissions to the current working dir (which
	    # can happen when deployed).
	    tempReport <- file.path(tempdir(), "report.Rmd")
	    file.copy(system.file("rmarkdown/templates/xlsform2word/skeleton/skeleton.Rmd", 
	                          package = "XlsFormUtil"), 
	              tempReport, overwrite = TRUE)
	    
	    # Set up parameters to pass to Rmd document
	    params = list( 
	      xlsformfile = AppReactiveValue$xlsformpath,
	      label_language = AppReactiveValue$language ,
	      # wpm  word per minute - an average 180 word per minute (per default) required to read loudly the text
	      wpm  = 180, 
	      # maxmodalities if more than 7 potential answers for a select question (per default)- then we assume that those modalities will not be read by the enumerator - but rather selected based on an open answer - and not be accounted for the modalities duration estimation
	      maxmodalities = 7 , 
	      # resptimeclose  an average 4 seconds (per default) for respondent to reply for closed questions
	      resptimeclose  = 4,
	      # resptimecondopen an average of  7 seconds (per default) to reply to conditional text question (accounting for question type of "other, please specify"). 
	      resptimecondopen = 7,
	      # resptimeopen an average of  10 seconds (per default) to reply to open text question. 
	      resptimeopen = 10,
	      # avrgrepeat In case of repeat questions, an average 3 repeat (per default) is accounted for. 
	      avrgrepeat = 3 )
	    
	    
	    id <- showNotification(
	      "Rendering report...", 
	      duration = NULL, 
	      closeButton = FALSE
	    )
	    on.exit(removeNotification(id), add = TRUE)
	    
	    # Knit the document, passing in the `params` list, and eval it in a
	    # child of the global environment (this isolates the code in the document
	    # from the code in this app).
	    rmarkdown::render(tempReport, 
	                      output_file = file,
	                      params = params,
	                      envir = new.env(parent = globalenv())
	    )
	  }
	)
	


}

## copy to body.R
# mod_pretty_print_ui("pretty_print_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "pretty_print",icon = icon("user"))

## and copy to app_server.R
# callModule(mod_pretty_print_server, "pretty_print_ui_1")

