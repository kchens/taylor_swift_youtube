$(document).ready(function() {
  bindEvents();
});

function bindEvents() {
  $(".vid-info").on("click", "#like-video", addLike);
  $(".vid-info").on("click", "#love-video", addLove);
}


function addLike(e) {
  e.preventDefault();

  var $likeThumb = $(e.target);
  var urlPath = $likeThumb.parent().attr("href");
  console.log(urlPath)
  ajaxRequest = $.ajax({
    url: urlPath,
    type: "POST"
  });
  ajaxRequest.done( function(e) {
    $likeThumb.text(e)
  });
  ajaxRequest.fail( function(e) {
    alert("AJAX Failure: You mean you LOVE this video?")
  })
}

function addLove(e) {
  e.preventDefault();

  var $loveHeart = $(e.target);
  var urlPath = $loveHeart.parent().attr("href");
  console.log(urlPath)
  ajaxRequest = $.ajax({
    url: urlPath,
    type: "POST"
  });
  ajaxRequest.done( function(e) {
    $loveHeart.text(e)
  });
  ajaxRequest.fail( function(e) {
    alert("AJAX Failure: No heart can encapsulate your love for TSwizzle.")
  })
}