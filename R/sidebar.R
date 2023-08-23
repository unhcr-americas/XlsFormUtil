#' UI Side menau
#'
#' This function is internally used to manage the side menu
#'
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal
#'
sidebar <- function() {
  shinydashboard::dashboardSidebar(
    shinydashboard::sidebarMenu(
      ## Here the menu item entry to the first module
      shinydashboard::menuItem("About",tabName = "home",icon = icon("bookmark")),
      
      shinydashboard::menuItem("Upload XlsFrom",tabName = "upload_form",icon = icon("highlighter")),
      shinydashboard::menuItem("Estimate Duration",tabName = "interview_duration",icon = icon("clock")),
      shinydashboard::menuItem("Generate Word Version",tabName = "pretty_print",icon = icon("print")),
      shinydashboard::menuItem("Compare with Base Form",tabName = "xlsform_compare",icon = icon("code-compare"))
      
      
      # - add more - separated by a comma!
      ## For icon search on https://fontawesome.com/search?o=r&m=free - filter on free
    )
  )
}