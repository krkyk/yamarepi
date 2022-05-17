/* トップページスライドショー */
$(document).on('turbolinks:load',function (){
const swiper = new Swiper('.swiper', {
  speed: 3000,
  spaceBetween: 10,
  effect: 'creative',
  creativeEffect: {
    prev: {
      translate: [0, 0, -400],
    },
    next: {
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
