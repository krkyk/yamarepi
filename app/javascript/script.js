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

/* アバウトページの画像フェードイン */
$(document).on('turbolinks:load',function () {
  $(".js-fadeUp").on("inview", function () {
    console.log("inview")
    $(this).addClass("is-inview");
  });
});

/* フラッシュメッセージの消去 */
$(document).on('turbolinks:load',function(){
  $('.flash').fadeOut(5000);
});
