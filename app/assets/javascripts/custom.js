$(document).on("turbolinks:load", function() {
  $(".topic-item").change(function () {
    $(this).toggleClass("picked-item");
  });
});
