ready = ->
  update_status()
  $('#invoice_status').change update_status

update_status = ->
  value = $('#invoice_status option:selected').text().replace(/\s+/g, '-').toLowerCase()
  action = $('#form_invoice').data("action")
  if action == "edit"
    $("." + value + "-show").show().attr('disabled', false);
    $("." + value + "-disable").attr('disabled', true);
    $("." + value + "-hide").hide()

$(document).ready(ready)
$(document).on('page:load', ready)