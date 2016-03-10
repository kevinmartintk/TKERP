ready = ->
  if current_scope "controller", "contacts"
    default_datepicker()
    type_ahead_clients()
    init()

init = ->

$(document).ready(ready)
$(document).on('page:load', ready)
