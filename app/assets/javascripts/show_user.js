$('#tabs a').click(function(e){
  alert('hey')
  e.preventDefault()
  $(this).tab(show)
})
