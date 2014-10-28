
/*
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
 */

(function() {
  var setClass;

  setClass = function(elementId, newClass) {
    var element;
    element = document.getElementById(elementId);
    return element.className = newClass;
  };

  window.onmousemove = function(event) {
    console.log(event.clientX);
    if (event.clientX < 200) {
      setClass('menu', 'menu revealed');
      return setClass('content', 'content revealed');
    } else {
      setClass('menu', 'menu');
      return setClass('content', 'content');
    }
  };

}).call(this);
