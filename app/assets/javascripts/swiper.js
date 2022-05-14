/* トップページスライドショー */
$(document).on('turbolinks:load',function (){
const swiper = new Swiper('.swiper', {
  speed: 3000,
  spaceBetween: 10,
  // effect: 'coverflow',
  //   // エフェクトの設定
  //   coverflowEffect: {
  //     depth: 500,
  //     modifire: 20
  //   },
  // effect: 'fade',
  // fadeEffect: {
  //   crossFade: true
  // },
  //
  effect: 'creative',
  creativeEffect: {
    prev: {
      // will set `translateZ(-400px)` on previous slides
      translate: [0, 0, -400],
    },
    next: {
      // will set `translateX(100%)` on next slides
      translate: ['100%', 0, 0],
    },
  },
  loop: true,
  autoplay: {
    delay: 800
  },
  scrollbar: {
    el: '.swiper-scrollbar',
    draggable: true,
  },
});
});
