ready = ->
  if current_scope "controller", "inventories"
    ajax_collaborator_dropdown()
    ajax_operating_system_dropdown()
    default_datepicker()
    picture_input()
    update_type()
    $('#inventory_type_id').change update_type
    $("#inventory_team").change ajax_collaborator_dropdown
    $("#inventory_type_id").change ajax_operating_system_dropdown  

update_type = ->
  type = default_format $("#inventory_type_id option:selected").text()
  show(type)
  hide(type)

ajax_collaborator_dropdown = ->
  $.ajax 'update_collaborators',
    type: 'GET'
    dataType: 'script'
    data:
      team_id: $("#inventory_team option:selected").val()
      collaborator_id: $("#inventory_collaborator_id").data("value")

ajax_operating_system_dropdown = ->
  $.ajax 'update_operating_systems',
    type: 'GET'
    dataType: 'script'
    data:
      type: $("#inventory_type_id option:selected").text()
      operating_system_id: $("#operating_system_id").data("value")

$(document).ready(ready)
$(document).on('page:load', ready)
