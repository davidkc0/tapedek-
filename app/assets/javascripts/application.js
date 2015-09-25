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
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .
//= require best_in_place
//= require jquery.timeago
//= require underscore

function onPlayerEvent (data) {
  data.forEach(function(event) {
    if (event.event == "videoPlaying") {
      $.each($(".clip_embed_player_flash"), function(x,y) {
        y.pauseVideo()
      });
    }
  }); 
}

function report_post_link () {
  $('.report_link').on('click', function(e) {
    $(this).replaceWith(function(){
        return $("<span>Thanks for reporting!</span>");
    });
  });
}

function tab_remember () {
  // set window hash on tab click
  $('ul.tab_remember').on('click', 'a', function(e){
    window.location.hash = e.target.hash;
  });

  // restore tab click on page refresh
  if (window.location.hash) {
    $('a[href$="' + window.location.hash + '"]').click();
  }
}

function ready () {
  postFunctions();
  tab_remember();
  socialSharing();
  $(".best_in_place").best_in_place();
  $("span.timeago").timeago();
  report_post_link();
  if (window.location.protocol != "http:")
    window.location.href = "http:" + window.location.href.substring(window.location.protocol.length);
}

$(document).ready(ready);
$(document).on('page:load', ready);
