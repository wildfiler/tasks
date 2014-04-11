#jQuery ->
#  if $('.projects-list').length > 0
#    $('.project-link').click (e)->
#      e.preventDefault()
#      $('.projects-list li').removeClass('active')
#      $(@).addClass('active')
#      $('.task-list').html('Loading...')
#      $.get $(@).children('a').attr('href'), (data)->
#        $('.task-list').html(data)
#
