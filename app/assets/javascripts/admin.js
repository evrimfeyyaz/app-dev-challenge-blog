//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks

// From http://web.archive.org/web/20110102112946/http://www.scottklarr.com/topic/425/how-to-insert-text-into-a-textarea-where-the-cursor-is/
function insertAtCaret(areaId,text) {
    var txtarea = document.getElementById(areaId);
    var scrollPos = txtarea.scrollTop;
    var strPos = 0;
    var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ? 
        "ff" : (document.selection ? "ie" : false ) );
    if (br == "ie") { 
        txtarea.focus();
        var range = document.selection.createRange();
        range.moveStart ('character', -txtarea.value.length);
        strPos = range.text.length;
    }
    else if (br == "ff") strPos = txtarea.selectionStart;

    var front = (txtarea.value).substring(0,strPos);  
    var back = (txtarea.value).substring(strPos,txtarea.value.length); 
    txtarea.value=front+text+back;
    strPos = strPos + text.length;
    if (br == "ie") { 
        txtarea.focus();
        var range = document.selection.createRange();
        range.moveStart ('character', -txtarea.value.length);
        range.moveStart ('character', strPos);
        range.moveEnd ('character', 0);
        range.select();
    }
    else if (br == "ff") {
        txtarea.selectionStart = strPos;
        txtarea.selectionEnd = strPos;
        txtarea.focus();
    }
    txtarea.scrollTop = scrollPos;
}
// From http://web.archive.org/web/20110102112946/http://www.scottklarr.com/topic/425/how-to-insert-text-into-a-textarea-where-the-cursor-is/

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(document).on('ready page:load', function() {
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

    $('[data-toggle="tooltip"]').tooltip();

    $('#chooseCoverImageButton').click(function() {
      $('#choose_image_mode').val('cover_image');
    })

    $('#addImageButton').click(function() {
      $('#choose_image_mode').val('add_image');
    })

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
      $container.masonry("reloadItems")
      $container.masonry();
    });

    $('#removeCoverImageButton').click(function(e) {
      e.preventDefault();

      if (confirm('Are you sure you would like to remove the cover image?')) {
        $('#post_image_id').removeAttr('value');
        $('img.cover-thumbnail').hide();
      }
    });

    // From http://stackoverflow.com/a/15880040
    $('#select-all').click(function() {
      $('.select-element').prop('checked', this.checked);
    });

    $('.select-element').click(function() {
      var check = ($('.select-element').filter(":checked").length == $('.select-element').length);
      $('#select-all').prop("checked", check);
    });
    // From http://stackoverflow.com/a/15880040

    $('span[data-time').each(function() {
      var date = $(this).data('time');
      var formattedDate = moment(date).format("MMM Do YYYY, h:mm a");

      $(this).text(formattedDate);
    });
});