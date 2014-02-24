jQuery ->
  notifications_div = $('.notifications')
  if notifications_div.length > 0
    notifications = notifications_div.data('flash')
    if notifications?.length > 0
      notifications.forEach (notification) ->
        notifications_div.notify(notification).show()
