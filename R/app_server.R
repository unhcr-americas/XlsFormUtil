#' Server
#'
#' This function is internally used to manage the shinyServer
#'
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal
app_server <- function(input, output, session) {

  ## add a reactive value object to pass by elements between objects
  AppReactiveValue <-  reactiveValues(
    
    chart =   ggplot2::ggplot() +
      ggplot2::annotate("text", x = 1, y = 1, size = 11,
                        label = "Please load file and press button..." ) +
      ggplot2::theme_void()
    
  )
  # pins::board_register() # connect to pin board if needed
  
  
 
  
  callModule(mod_home_server, "home_ui_1")
  callModule(mod_upload_form_server, "upload_form_ui_1", AppReactiveValue)
  callModule(mod_interview_duration_server, "interview_duration_ui_1", AppReactiveValue)
  callModule(mod_pretty_print_server, "pretty_print_ui_1", AppReactiveValue)
  callModule(mod_xlsform_compare_server, "xlsform_compare_ui_1", AppReactiveValue)
}
