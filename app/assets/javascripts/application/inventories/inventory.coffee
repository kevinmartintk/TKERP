ready = ->
  if current_scope "invoices"
    ajax_collaborator_dropdown()
    ajax_operating_system_dropdown()
    datepicker()
    pictureInput()
    update_type()
    $('#inventory_type_id').change update_type
    $("#inventory_team").change ajax_collaborator_dropdown
    $("#inventory_type_id").change ajax_operating_system_dropdown

datepicker = ->
  $('.datepicker').datepicker
    format: "yyyy-mm-dd"
    autoclose: true
    todayHighlight: true
    endDate: new Date()

update_type = ->
  type = default_format $("#inventory_type_id option:selected").text()
  show(type)
  hide(type)

pictureInput = ->
  $('.pictureInput').on 'change', (event) ->
    files = event.target.files
    image = files[0]
    reader = new FileReader()
    reader.onload = (file) ->
      img = new Image()
      img.src = file.target.result
      $('#target').html(img)
      img.style.height = '180px'
      img.style.width = 'auto'
    reader.readAsDataURL(image)
    $("#endTimeLabel").removeClass()

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
