$(document).ready(function() {
  bindEvents();
});

function bindEvents() {
  $("#like-video").on("click", incrementLikeLove);
  $("#love-video").on("click", incrementLikeLove);
}

function incrementLikeLove(e) {
  e.preventDefault();
  var $thumbOrHeart = $(e.target);

  var urlPath = $thumbOrHeart.parent().attr("href");
  var id = $thumbOrHeart.parent().attr('id')
  if (id === "like-video") {
    var data = {button: "like-video"};
  } else {
    var data = {button: "love-video"};
  }

  ajaxRequest = $.ajax({
    url: urlPath,
    type: "POST",
    data: data
  });
  ajaxRequest.done( function(e) {
    $thumbOrHeart.text(e);
    setTimeout(
    function() {
      $("#t-vid").attr("src", "//www.youtube.com/embed/PAhAz7JU0dg?rel=0")
    }, 1000);
    alert("You need to calm down. Take some Swiftamine.")
  });
  ajaxRequest.fail( function(e) {
    if (id === "like-video") {
      alert("AJAX Failure: You mean you LOVE this video?")
    } else {
      alert("AJAX Failure: No heart can encapsulate your love for TSwizzle.")
    }
  })
}
