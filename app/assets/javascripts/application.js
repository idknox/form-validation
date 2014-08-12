//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery-ui

$(function () {
  $('.cal-date').datepicker({ dateFormat: "yy-mm-dd"});
});


$(document).ready(function () {

//  Accordion
  $('.tasks').hide();
  $('.fa-caret-down').hide();
  $('.open').click(function () {
    $(this).siblings('.tasks').slideToggle();
    $(this).find('.fa-caret-down').toggle();
    $(this).find('.fa-caret-right').toggle();
    $('.tasks').not($(this).siblings('.tasks')).slideUp();
  });

//  Hide Flash

  var stopFlash = function () {
    $('.flash').slideUp()
  };

  window.setTimeout(stopFlash, 5000)


  $('.fa-times').click(function () {
    $('.flash').slideUp()
  })

  $('.task').each( function () {
    if ($(this).find('.time').text() == 0) {
      $(this).css('background-color', '#FFC683')
    }
    else if ($(this).find('.time').text() < 0) {
      $(this).css('background-color', '#FF9189')
    }
  });

});


