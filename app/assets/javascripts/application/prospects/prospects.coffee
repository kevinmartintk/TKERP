ready = ->
  if current_scope "controller", "prospects"
    default_datepicker()
    set_today_date()
    type_ahead_clients()

set_today_date = ->
  myDate = new Date();
  today = myDate.getFullYear() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getDate();

  if $('#prospect_arrival_date').val() == null or $('#prospect_arrival_date').val() == ""
    $("#prospect_arrival_date").datepicker("setDate", today)

$(document).ready(ready)
$(document).on('page:load', ready)