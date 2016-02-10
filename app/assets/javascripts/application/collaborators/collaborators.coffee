ready = ->
  if current_scope "controller", "collaborators"
    default_datepicker()
    picture_input()
    default_tab()

$(document).ready(ready)
$(document).on('page:load', ready)