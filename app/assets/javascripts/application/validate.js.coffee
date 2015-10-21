ready = ->
	$('.validate').validationEngine()
	$('[data-toggle="tooltip"]').tooltip()

$(document).ready(ready)
$(document).on('page:load', ready)