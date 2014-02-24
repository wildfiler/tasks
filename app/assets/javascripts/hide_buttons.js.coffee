jQuery ->
  tables = $("table.hide-buttons")
  if tables.length >0
    tables.find('.btn').hide()
    tables.find('tr').hover ->
      $(@).find('.btn').show()
    , ->
      $(@).find('.btn').hide()

    # tables.each (idx, table) ->
    #   $(table).find('tr').each (idx, row) ->
    #     $(row).hover
