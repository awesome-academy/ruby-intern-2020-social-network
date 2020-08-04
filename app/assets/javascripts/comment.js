$(document).on("turbolinks:load", function() {
  $('.btn-comment').click(function(e) {
    e.preventDefault();
    let postId = $(this).attr('post_id');
    $('#comment_root_post_' + postId).focus();
  });
});
