// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function renderMonthsCounts(data, appendToElement){
  data = $(data).hide();
  $(appendToElement).append(data);
  $(data).slideDown();
}

function animateButton(button){
  $(button).toggleClass('rotate');
}

function handleLoadMonthsCountsError(request, errorType, errorMessage){
  var flash = $('.flash');
  var newMessage = $("<div class='alert alert-alert'>" + errorType + ': ' + errorMessage + '</div>');
  var existingMessage = $(flash.find('.alert')[0]);
  if (newMessage.text() != existingMessage.text()) {
    flash.append(newMessage);
  }
}

function loadMonthsCounts(button){
  var toMonthsCountsLink = button;
  var year=$(toMonthsCountsLink).attr('id');
  $.ajax('/posts_by/'+year, {
    success: function(response) {
      renderMonthsCounts(response, $(toMonthsCountsLink).parent());
      animateButton(toMonthsCountsLink);
    },
    error: handleLoadMonthsCountsError,
    timeout: 4000,
    beforeSend: function() {
      $(toMonthsCountsLink).after($("<i class='fa fa-spinner fa-spin'></i>"));
    },
    complete: function() {
      $(toMonthsCountsLink).next().remove();
    }
  });
}

$(function() {
  $('.sidebar').on('click', '.months', function(e){
    e.preventDefault();
    if ($(this).attr('class') == 'months rotate') {
      animateButton(this);
      var monthsCountsMenu = $(this).parent().find('ul');
      $(monthsCountsMenu).slideUp();
    } else {
      loadMonthsCounts(this);
    }
  });
});
