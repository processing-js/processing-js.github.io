document.addEventListener("DOMContentLoaded", function(e) {
  var path = location.pathname.substring(0, location.pathname.indexOf('/', 1) + 1);
  if (path) {
    var list = document.querySelectorAll("div.navbar ul li a");
    for (var item in list) {
      item = list[item];
      if (item.href.indexOf(path) != -1) {
        item.className += " selected ";
        break;
      }
    }
  } else {
    var item = document.querySelector("div.navbar ul li a");
    item.className = item.className + " selected ";
  }
}, false);
