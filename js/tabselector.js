$(function() {
  $("div.navbar ul li a").filter("[href='" + location.pathname + "']").addClass("selected");
});
