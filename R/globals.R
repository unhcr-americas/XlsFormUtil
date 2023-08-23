# remotes::install_github("thinkr-open/checkhelper")
# checkhelper::print_globals()

globalVariables(unique(c(
  # fct_create_flextable: 
  "Choices", "rows", 
  # fct_interview_duration: 
  "count", "is_note", "is_question", "is_repeated", "label", "label_duration", "labelmod", "labelmod_duration", "labelmod_word", "list_name", "modality_duration", "name", "question_duration", "question_duration_sum", "readtime", "repeat_duration", "repeatvar", "response_duration", "type", "type2", 
  # fct_tabulate_form: 
  "constraint_message", "hint", "id", "instruct", "label", "label_hint", "labelmod", "labelnamemod", "list_name", "name", "namemod", "new_list", "relevant", "type", "Questions", "Variables",
  # fct_xlsform_compare: 
  "constraint", "form_file", "hint", "label", "list_name", "name", "relevant", "required", "type",
  
  # mod_home_server: 
  "parent_session"
)))