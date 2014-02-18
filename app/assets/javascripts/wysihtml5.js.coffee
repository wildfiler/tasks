$(document).ready ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5()
    wysihtml =  $('.wysihtml5-toolbar a').attr('tabindex', '-1')
