/* トップへ戻るボタン */
$(document).on('turbolinks:load',function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});


/* レシピ画像プレビュー */
$(document).on('turbolinks:load',function (){
  $('#recipe_recipe_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $("#preview").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
});
});

/* トップページスライドショー */
$(document).ready(function(){
  $("#theTarget").skippr({
    transition:"slide",
    speed:1000,
    easing:"easeOutQuart",
    navType:"bubble",
    childrenElementType:"div",
    arrows:true,
    autoPlay:true,
    autoPlayDuration:3000,
    keybordOnAlways:true,
    hidePrevious:false
  })
});

/* アバウトページの画像フェードイン */
$(document).on('turbolinks:load',function(){
  $(".animationTarget").on("inview", function (event, isInView) {
    if (isInView) {
      $(this).stop().addClass("fadeInDown");
    }
  });
});
