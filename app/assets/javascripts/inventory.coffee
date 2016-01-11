$ ->
  $(document).on 'change', '#inventory_team', (evt) ->
    $.ajax 'update_collaborators',
      type: 'GET'
      dataType: 'script'
      data: {
        team_id: $("#inventory_team option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic collaborator select OK!")

