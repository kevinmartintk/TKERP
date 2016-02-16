ready = ->
  if current_scope "controller", "clients"
    update_country()
    $('#entity_country_id').change update_country

update_country = ->
  country = default_format $('#entity_country_id option:selected').text()
  switch country
    when "peru" then validate_ruc()
    else validate_legal_id()

validate_ruc = ->
  $('#legal_id_label').text("RUC");
  $('#entity_legal_id').addClass("validate[required, custom[customRuc]]");
  $('#entity_legal_id').removeClass("validate[required]");

validate_legal_id = ->
  $('#legal_id_label').text("Legal identification");
  $('#entity_legal_id').addClass("validate[required]");
  $('#entity_legal_id').removeClass("validate[required, custom[customRuc]]");

$(document).ready(ready)
$(document).on('page:load', ready)