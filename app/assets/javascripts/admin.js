//= require jquery_ujs
//= require turbolinks

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function() {
    $(window).bind("load resize", function() {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });

    var url = window.location;
    var element = $('ul.nav a').filter(function() {
        return this.href == url || url.href.indexOf(this.href) == 0;
    }).addClass('active').parent().parent().addClass('in').parent();
    if (element.is('li')) {
        element.addClass('active');
    }
});

var $container = $('.grid');
$container.masonry({
  itemSelector: '.grid-item', // use a separate class for itemSelector, other than .col-
  columnWidth: '.grid-item',
  percentPosition: true
});

$('a[data-toggle=modal]').each(function () {
  var $this = $(this);

  $this.on('click', function () {
    setTimeout(function() {
      $container.masonry();
    }, 250);
  });
});

$('input[name=preview_button]').click(function(e) {
  $('.new_post, .edit_post').prop('target', '_blank');
});

$('input[name=commit], input[name=save_and_publish_button]').click(function(e) {
  $('.new_post, .edit_post').prop('target', '_self');
});

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
});