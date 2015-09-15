function postFunctions() {
  $("#helpBlock").on("click", function () {
    $("#urlFormattingList").toggle();
  });

  $(".reply_button").on('click', function () {
    $(this).parent().next('.reply_form').toggle();
  });

  $("#new_post").on('submit', function (e) {
    // e.preventDefault();
    var $tag_list = $("#post_tag_list"),
        tags = $tag_list.val().toLowerCase().split(" ").join("").split(","),
        uniqueTags = [];

    $.each(tags, function(i, el){
        if($.inArray(el, uniqueTags) === -1) uniqueTags.push(el);
    });
    $tag_list.val(uniqueTags.join(","))
  });
}