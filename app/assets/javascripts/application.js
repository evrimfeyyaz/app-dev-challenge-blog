// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery_ujs
//= require turbolinks

var onloadCallback = function() {
  if ($('#g-recaptcha').length) {
    grecaptcha.render('g-recaptcha', {
      'sitekey' : '6Ld7pBcTAAAAAP7e_5B_Fk0SA6iqiuXqREH2I7f2'
    });
  }
};

$(document).on('ready page:load', function() {
  $('.grid').masonry({
    itemSelector: '.grid-item', // use a separate class for itemSelector, other than .col-
    columnWidth: '.grid-item',
    percentPosition: true
  });
});