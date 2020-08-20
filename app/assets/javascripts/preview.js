$(document).on("turbolinks:load", function() {
  $('.form-control').change(function(e) {
    var file = $("input[type=file]").get(0).files[0];
    if(file) {
      var reader = new FileReader();
      reader.onload = function() {
        $('#previewImg_avatar').attr("src", reader.result);
      }
      reader.readAsDataURL(file);
    } else {
      var file = $("input[type=file]").get(1).files[0];
      if(file) {
        var reader = new FileReader();
        reader.onload = function() {
          $('#previewImg_background').attr("src", reader.result);
        }
        reader.readAsDataURL(file);
      }
    }
  });

  $('#post_images_post').change(function(e) {
    let files = this.files
    for (let index = 0; index < files.length; ++index) {
     let imageUrl = URL.createObjectURL(files[index])
     let imageEl = document.createElement("IMG")
     imageEl.setAttribute("src", imageUrl)
     imageEl.setAttribute("width", "150px")
     imageEl.setAttribute("height", "150px")
     $('#preview-images').append(imageEl)
   }
 });
});
