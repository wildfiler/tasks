jQuery ->
  console.log 'notifications!'
  notifications_div = $('.notifications')
  if notifications_div.length > 0
    console.log 'we have notifications div!'
    notifications = notifications_div.data('flash')
    notifications.forEach (notification) ->
      console.log notification
      notifications_div.notify(notification).show()
