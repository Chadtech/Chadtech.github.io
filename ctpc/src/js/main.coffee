addClass = (elementId, classNamet) ->
  element = document.getElementById elementId
  element.className += ' ' + classNamet

removeClass = (elementId, className) ->
  element = document.getElementById elementId
  console.log element
  element.className = 'title'

scrollMenu = (event) ->
  scrollTop = document.documentElement.scrollTop or document.body.scrollTop
  if scrollTop > 50
    addClass 'title', 'scrolled'
  else
    console.log 'A'
    removeClass 'title', 'scrolled'

window.onscroll = scrollMenu