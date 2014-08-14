//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery-ui
//= require jMagnify

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

  window.setTimeout(stopFlash, 5000);


  $('.fa-times').click(function () {
    $('.flash').slideUp()
  });

// Change task colors

  $('.task').each(function () {
    if ($(this).find('.time').text() == 0) {
      $(this).css('background-color', '#FFC683')
    }
    else if ($(this).find('.time').text() < 0) {
      $(this).css('background-color', '#FF9189')
    }
  });

//  Unheap plugin

  $().ready(function () {
    $('.task_list').jMagnify();
  });


// Form Validation

  $('.submit').attr('disabled', 'disabled');

  $('.form_list input').on({
    blur: function () {
      $('.submit').removeAttr('disabled');
      if ($(this).val().length < 1) {
        $(this).addClass('invalid');
      }
    },
    keyup: function () {
      $('.submit').removeAttr('disabled');
    }
  });

//  --- PRINT ERRORS __
  form = $('.add_task');
  errors = $('.errors');

  form.submit(function (e) {
    var valid = true;

    $('.form_list input').each(function (_, item) {
      if ($(item).val().length < 1) {
        valid = false;
      }
    });

    if (valid) {
      $('.submit').attr('disabled', 'disabled')
    }
    else {
      e.preventDefault();
      errors.empty();
      errors.prepend('All fields must be filled');
    }
  });

//  --- DISABLE BUTTON ON SUBMIT ---

//  $('.submit').on('click', function () {
//    $(this).attr('disabled', 'disabled');
//    return true;
//  });

//  --- CLEAR FORM ---

  $('.clear').on('click', function () {
    $('.add_task input').each(function () {
//      $(this).val() = '';
      $('.submit').attr('disabled', 'disabled');
    });
  });

});


