ready = ->
  if current_scope "controller", "contacts"
    default_datepicker()
    type_ahead_clients()
    init()

init = ->
  $("#person_client_name").bind "focusout", ->
    $(".tt-hint").removeClass("validate[required]")

$(document).ready(ready)
$(document).on('page:load', ready)