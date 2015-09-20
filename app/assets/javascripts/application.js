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
function onPlayerEvent (data) {
  data.forEach(function(event) {
    if (event.event == "videoPlaying") {
      $.each($(".clip_embed_player_flash"), function(x,y) {
        y.pauseVideo()
      });
    }
  }); 
}

function insta_embed (id) {
  $.ajax({
    dataType: "jsonp",
    url: 'http://api.instagram.com/oembed',
    data: {
            url: "http://instagr.am/p/" + id
          },
    success: function(data) {
      $("#"+id).html(data.html)
    }      
  });
}

function ready () {
  postFunctions();
  $(".best_in_place").best_in_place();
  $("span.timeago").timeago();
}

$(document).ready(ready);
$(document).on('page:load', ready);
