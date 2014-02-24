jQuery ->
  # tables = $("table.hide-buttons")
  # if tables.length >0
    # tables.find('.btn').hide()
    # tables.on 'hover', 'tr', ->
    #   $(@).find('.btn').show()
    # , ->
    #   $(@).find('.btn').hide()
  $(document).on {
              mouseenter: -> $(@).find('.btn').show(),
              mouseleave: -> $(@).find('.btn').hide()
            }, 'table.hide-buttons tr'
