(function() {
  var addClass, removeClass, scrollMenu;

  addClass = function(elementId, classNamet) {
    var element;
    element = document.getElementById(elementId);
    return element.className += ' ' + classNamet;
  };

  removeClass = function(elementId, className) {
    var element;
    element = document.getElementById(elementId);
    console.log(element);
    return element.className = 'title';
  };

  scrollMenu = function(event) {
    var scrollTop;
    scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    if (scrollTop > 50) {
      return addClass('title', 'scrolled');
    } else {
      console.log('A');
      return removeClass('title', 'scrolled');
    }
  };

  window.onscroll = scrollMenu;

}).call(this);
