//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery-ui

$(function () {
  $('.cal-date').datepicker({ dateFormat: "yy-mm-dd"});
});


$(document).ready(function () {
  $('.about').hover(function () {
    $(this).toggle(1000, function() {
      $(this).css('margin-left', '-50px')
  });
});
});


