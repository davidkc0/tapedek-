function postFunctions() {
  $("#helpBlock").on("click", function () {
    $("#urlFormattingList").toggle();
  });

  $(".reply_button").on('click', function () {
    $(this).parent().next('.reply_form').toggle();
  });
}