ready = ->
  if current_scope "controller", "inventories"
    default_datepicker()
    picture_input()
    update_type()
    ajax()
    

ajax = ->
  ajax_collaborator_dropdown() unless current_scope "action", "index"
  ajax_operating_system_dropdown() unless current_scope "action", "index"
  $('#inventory_type_id').change update_type
  $("#inventory_team_id").change ajax_collaborator_dropdown
  $("#inventory_type_id").change ajax_operating_system_dropdown  

update_type = ->
  type = default_format $("#inventory_type_id option:selected").text()
  show(type)
  hide(type)

ajax_collaborator_dropdown = ->
  console.log "asdasd"
  $.ajax 'update_collaborators',
    type: 'GET'
    dataType: 'script'
    data:
      team_id: $("#inventory_team_id option:selected").val()
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
