update_radio_button = (radio_button) ->
  $('input:radio[name=' + radio_button + ']').change ->
    switch $(this).val()
      when "yes" then $("." + radio_button).removeClass "hide"
      when "no" then $("." + radio_button).addClass "hide"

init = ->
  month_datepicker()
  update_radio_button "has_family"
  update_radio_button "has_children"
  update_radio_button "has_partner"
  ajax_insurance_types_dropdown() if current_scope "action", "new"
  ajax_insurance_types_dropdown() if current_scope "action", "edit"
  $("#person_collaborator_attributes_insurance").change ajax_insurance_types_dropdown

month_datepicker = ->
  $(".month-datepicker").datepicker
    format: "mm-yyyy"
    startView: "months"
    minViewMode: "months"

ajax_insurance_types_dropdown = ->
  $.ajax 'update_insurance_types',
    type: 'GET'
    dataType: 'script'
    data:
      insurance: $("#person_collaborator_attributes_insurance option:selected").val()
      insurance_type: $("#person_collaborator_attributes_insurance_type").data("value") 

ready = ->
  if current_scope "controller", "collaborators"
    default_datepicker()
    picture_input()
    default_tab()
    init()

$(document).ready(ready)
$(document).on('page:load', ready)