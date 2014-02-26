jQuery ->
  $(document).on {
              mouseenter: -> $(@).find('.button').show(),
              mouseleave: -> $(@).find('.button').hide()
            }, 'table.hide-buttons tr'
