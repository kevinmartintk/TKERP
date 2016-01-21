ready = ->
  update_status()
  $('#invoice_status').change update_status

update_status = ->
  value = default_format $('#invoice_status option:selected').text()
  action = $('#form_invoice').data("action")
  switch action 
    when "edit", "update"
      show(value)
      disable(value)
      hide(value)

$(document).ready(ready)
$(document).on('page:load', ready)