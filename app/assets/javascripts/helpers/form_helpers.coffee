@show = (value) ->
  $("." + value + "-show").removeClass("hide disabled")

@disable = (value) ->
  $("." + value + "-disable").attr('disabled', true);

@hide = (value) ->
  $("." + value + "-hide").addClass("hide")

@default_format = (string) ->
  string.replace(/\s+/g, '-').toLowerCase()

@current_scope = (controller_name) ->
  $("#wrapper").data("controller").search(controller_name) >= 0