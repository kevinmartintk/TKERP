ready = ->
  if current_scope "controller", "contacts"
    default_datepicker()
    type_ahead_clients()

$(document).ready(ready)
$(document).on('page:load', ready)