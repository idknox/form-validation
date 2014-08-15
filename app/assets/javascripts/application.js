//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery-ui
//= require jMagnify

$(function () {
  $('.cal-date').datepicker({ dateFormat: "yy-mm-dd"});
});


$(document).ready(function () {

//  ACCORDION

//  $('.tasks').hide();
//  $('.fa-caret-down').hide();
//  $('.open').click(function () {
//    $(this).siblings('.tasks').slideToggle();
//    $(this).find('.fa-caret-down').toggle();
//    $(this).find('.fa-caret-right').toggle();
//    $('.tasks').not($(this).siblings('.tasks')).slideUp();
//  });

// --- HIDE FLASH ---

  var stopFlash = function () {
    $('.flash').slideUp()
  };

  window.setTimeout(stopFlash, 5000);


  $('.fa-times').click(function () {
    $('.flash').slideUp()
  });

// --- CHANGE TASK COLORS ---

  $('.task').each(function () {
    if ($(this).find('.time').text() == 0) {
      $(this).css('background-color', '#FFC683')
    }
    else if ($(this).find('.time').text() < 0) {
      $(this).css('background-color', '#FF9189')
    }
  });

// --- UNHEAP PLUGIN ---

  $().ready(function () {
    $('.task_list').jMagnify();
  });


// --- FORM VALIDATION --

  var form = $('.add_task');
  var errors = $('.errors');
  var inputs = $(".form_list :input");

  var isValid = function (input) {
    return (input.val() != '')
  };

  $('.submit').attr('disabled', 'disabled');

  inputs.on('blur keyup change', function () {
    $('.submit').removeAttr('disabled');
    if (isValid($(this))) {
      $(this).removeClass('invalid');
    } else {
      $(this).addClass('invalid');
    }
  });

  $('.task_list_name').on('blur', function () {
    if ($(this).val().length < 21 && $(this.val().length > 0)) {
      $(this).removeClass('invalid');
    } else {
      $(this).addClass('invalid');
    }
  });

//  --- PRINT ERRORS __

  form.submit(function (e) {
    var valid = true;

    inputs.each(function () {
      if ($(this).hasClass('invalid')) {
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


  $('.clear').on('click', function () {
    $('.add_task input').each(function () {
      $(this).val() = '';
    });
    $('.submit').attr('disabled', 'disabled');
  });

//  --- FILTER ---

  // Custom case-insensitive :contains
  jQuery.expr[':'].containsCaseInsensitive = function(a, i, m) {
    return jQuery(a).text().toUpperCase()
      .indexOf(m[3].toUpperCase()) >= 0;
  };

  if ($('.filter').val() == '') {
    $('.task').removeClass('hidden');
  }

  $('.filter').on('keyup', function () {
    var filter = $(this).val();
    var tasks = $('.task');
    var results = $('.task_description:containsCaseInsensitive(' + filter + ')');

    tasks.hide();
    tasks.addClass('hidden');

    results.parents('.task').show();
    results.parents('.task').removeClass('hidden');

    $('section').each(function () {
      if ($(this).find('.hidden').length == $(this).find('.task').length) {
        $(this).hide();
      } else {
        $(this).show();
      }
    });
  });

//  --- ClEAR FILTER ---

  $('.clear_filter').on('click', function () {
    $('.filter').empty();
    $('.hidden').removeClass('hidden');
  });

});


