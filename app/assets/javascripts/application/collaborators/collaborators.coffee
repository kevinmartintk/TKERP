update_radio_button = (radio_button) ->
  $('input:radio[name=' + radio_button + ']').change ->
    switch $(this).val()
      when "yes" then $("." + radio_button).removeClass "hide"
      when "no" then $("." + radio_button).addClass "hide"

questions = ->
  update_radio_button "has_family"
  update_radio_button "has_children"
  update_radio_button "has_partner"

ready = ->
  if current_scope "controller", "collaborators"
    default_datepicker()
    picture_input()
    default_tab()
    questions()

$(document).ready(ready)
$(document).on('page:load', ready)