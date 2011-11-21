$(function() {
  var path = location.pathname.substring(0, location.pathname.indexOf('/', 1) + 1);
  if (path) {
    $("div.navbar ul li a").filter("[href^='" + path + "']").addClass("selected");
  } else {
    $("div.navbar ul li a:first").addClass("selected");
  }
});
