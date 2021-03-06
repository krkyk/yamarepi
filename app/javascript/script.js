/* トップへ戻るボタン */
$(document).on('turbolinks:load',function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
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

/* レシピ画像編集プレビュー */
$(document).on('turbolinks:load',function () {
  $('#recipe_recipe_img').change(function (e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    reader.onload = (function (file) {
      return function (e) {
        $("#preview").attr("src", e.target.result);
        $("#preview").attr("title", file.name);
      };
    })(file);
    reader.readAsDataURL(file);
  });
});

/* 会員画像編集プレビュー */
$(document).on('turbolinks:load',function () {
  $('#customer_customer_image').change(function (e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    reader.onload = (function (file) {
      return function (e) {
        $("#customer-preview").attr("src", e.target.result);
        $("#customer-preview").attr("title", file.name);
      };
    })(file);
    reader.readAsDataURL(file);
  });
});

/* ローディング画面の表示 */
$(document).on('turbolinks:load',function () {
  $(document).ready(function(){
    $("#loading").delay(1500).fadeOut('slow');
    $("#loading_box").delay(1200).fadeOut('slow');
  });
});
