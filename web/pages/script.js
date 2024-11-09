new Swiper('.swiper', {
  loop: true,
  slidesPerView: 4,
  spaceBetween: 40,
  autoplay: {
        delay: 2000,
        disableOnInteraction: false
    },
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  }
});

new Swiper('.carrosel', {
  loop: true,
  slidesPerView: 4,
  spaceBetween: 10,
  autoplay: {
        delay: 2000,
        disableOnInteraction: false
    },
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  }
});
