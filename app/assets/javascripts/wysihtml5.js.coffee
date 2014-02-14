$(document).ready ->
  console.log('founded!') 
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5()
    console.log('founded!')