# Module UI

#' @title mod_interview_duration_ui and mod_interview_duration_server
#' @description A shiny module.
#' @description A shiny module.
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import shiny
#' @import shinydashboard
#' @keywords internal

mod_interview_duration_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "interview_duration",
		fluidRow(
		  column(
		    width = 12,
		    h2('Interview Duration Estimate'),
		    p("When designing a questionnaire, it is key to keep the interview
	  duration under control. Ideally less than 20 minutes for a phone interview
    and less than 40 minutes for a face to face interview."),
		  p("The function is designed to provide a rough estimate (aka a guesstimate...)
   of the interview duration in order to assess this element of questionnaire
   design quality. the questionnaire takes too long, then one needs to trim
   it or split it into multiple ones..."),
		  p("The estimations provided in that function are based on a series of assumptions
    and accounts for the following elements.")
		  ),
		  fluidRow(
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
      		      width = 4,
      		      # actionButton( inputId =  ns("estimate"),
      		      #               label = " Click here to Display Interview Duration Estimation",
      		      #               class = "btn-success" ,
      		      #               icon = shiny::icon("clock")),
      		      # p(tags$i( class = "fa-solid fa-hand-point-down"),
      		      # " Below, you can adjust the default parameters and
      		      #   then regenerate the estimation by pressing the same button",
      		      # tags$i( class = "fa-solid fa-hand-point-up")),
      		      # hr(),

      		      sliderInput( inputId =   ns("wpm"),
      		       label = "Average Word per Minute required to read loudly the text.",
      		       value = 180 , min = 130, max = 230, step = 5 ,
      		                 width = '400px'),
      		     p( "Questions hint are not accounted for as they tips for enumerator and not
                 to be read to respondent",
      		        style = "font-size: 12px") ,
      		     hr(),
      		      sliderInput( inputId =   ns("maxmodalities"),
      		             label = "Average number of potential answers to read ",
      		             value = 7 ,  min = 2 , max = 12, step = 1,
      		             width = '400px'),
      		     p( "for a select question above which we assume that each modalities will not be read by the
                        		    enumerator - but rather selected based on an open answer - and not be
                        		    accounted for the modalities duration estimation",
      		        style = "font-size: 12px") ,
      		     hr(),
      		      sliderInput( inputId =   ns("resptimeclose"),
      		             label = "Average time in seconds for respondent to reply for closed questions",
      		             value = 4 ,  min = 1 , max = 15, step = 1 ,
      		             width = '400px'),
      		     hr(),
      		      sliderInput( inputId =   ns("resptimecondopen"),
      		             label = "Average time in seconds to reply  to conditional text question",
      		             value = 7 ,  min = 2 , max = 15, step = 1 ,
      		             width = '400px'),
      		     p( "(accounting for question type of  \"other, please specify\")",
      		        style = "font-size: 12px") ,
      		     hr(),
      		      sliderInput( inputId =   ns("resptimeopen"),
      		             label = "Average time in seconds to reply to open text question",
      		             value = 10 ,  min = 2 , max = 20, step = 1 ,
      		             width = '400px'),
      		     hr(),
      		      sliderInput( inputId =   ns("avrgrepeat"),
      		             label = "Average number of repeat respondant to account for",
      		             value = 3 ,  min = 1 , max = 10, step = 1 ,
      		             width = '400px'),
      		     p( "Used in case of repeat questions within the form",
      		        style = "font-size: 12px")
      		    ),
          		column(
          		  width = 8,
          		  plotOutput(outputId = ns("plot"),
          		             width = "100%",
          		             height = "400px",)
          		)
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

mod_interview_duration_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
	
	
	
	observeEvent(input$wpm, {
	  AppReactiveValue$wpm <- input$wpm
	})
	
	observeEvent(input$maxmodalities, {
	  AppReactiveValue$maxmodalities <- input$maxmodalities
	})
	
	observeEvent(input$resptimeclose, {
	  AppReactiveValue$resptimeclose <- input$resptimeclose
	})
	
	observeEvent(input$resptimecondopen, {
	  AppReactiveValue$resptimecondopen <- input$resptimecondopen
	})
	
	observeEvent(input$avrgrepeat, {
	  AppReactiveValue$avrgrepeat <- input$avrgrepeat
	})

	output$plot <- renderPlot({
	  
	  req(AppReactiveValue$xlsformpath)
	  message("Please upload a file")
	  
	  result <- fct_interview_duration(
	    xlsformpath =  AppReactiveValue$xlsformpath,
	    label_language = AppReactiveValue$language,
	    # wpm  word per minute - an average 180 word per minute (per default) required to read loudly the text
	    wpm  =  input$wpm,
	    # maxmodalities if more than 7 potential answers for a select question (per default)- then we assume that those modalities will not be read by the enumerator - but rather selected based on an open answer - and not be accounted for the modalities duration estimation
	    maxmodalities = input$maxmodalities ,
	    # resptimeclose  an average 4 seconds (per default) for respondent to reply for closed questions
	    resptimeclose  =  input$resptimeclose,
	    # resptimecondopen an average of  7 seconds (per default) to reply to conditional text question (accounting for question type of "other, please specify").
	    resptimecondopen =  input$resptimecondopen,
	    # resptimeopen an average of  10 seconds (per default) to reply to open text question.
	    resptimeopen =  input$resptimeopen,
	    # avrgrepeat In case of repeat questions, an average 3 repeat (per default) is accounted for.
	    avrgrepeat = input$avrgrepeat   )
	  
	  AppReactiveValue$chart <-  result[["plot"]]
	  AppReactiveValue$chart
	}	)
}

## copy to body.R
# mod_interview_duration_ui("interview_duration_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "interview_duration",icon = icon("user"))

## and copy to app_server.R
# callModule(mod_interview_duration_server, "interview_duration_ui_1")

