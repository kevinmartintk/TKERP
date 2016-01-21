ready = ->
  if current_scope "invoices"
    update_status()
    resize_labels()
    $(".table-responsive").bind("scroll", resize_labels);
    $('#invoice_status').change update_status

update_status = ->
  value = default_format $('#invoice_status option:selected').text()
  action = $('#form_invoice').data("action")
  switch action 
    when "edit", "update"
      show(value)
      disable(value)
      hide(value)

resize_labels = ->
  if current_scope "invoices"
    position_amount = $('#amount-cell').position()
    position_left_soles = "#{position_amount.left - 16}px"
    position_left_dollar = "#{position_amount.left - 5}px"
    style = (pos) ->
       position: 'absolute'
       'left': pos
    $('.soles-detail').css style(position_left_soles)
    $('.dollar-detail').css style(position_left_dollar)

$(document).ready(ready)
$(document).on('page:load', ready)
$(window).resize(resize_labels)
