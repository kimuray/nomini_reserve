$(function () {
  $('.alert-area').mouseover(function(){
    $('.alert-area').hide('fade', '', 500);
  });

  $('#shop_prefecture_id').change(function() {
    $.get({
      url: "/api/cities",
      data: { prefecture_id: $('#shop_prefecture_id').has('option:selected').val() }
    });
  });
})


$(function() {
  if($('#reservation_category_select').length) {
    // ラジオボタンに選択よってコースセレクトボックスの出し入れ
    $('#reservation_course').on('click', function () {
      $('#reservation_category_select').addClass("show");
      $('#reservation_alacarte_price').removeClass("show");
    });
    $('#reservation_alacarte').on('click', function () {
      $('#reservation_category_select').removeClass("show");
      $('#reservation_alacarte_price').addClass("show");
    });

    // 画面レンダリング時のラジオボタン確認
    if($("#reservation_course").prop('checked')) {
      $('#reservation_category_select').addClass("show");
    }
    if($("#reservation_alacarte").prop('checked')) {
      $('#reservation_alacarte_price').addClass("show");
    }
  }
});

// 電話番号リンクPCの場合無効化
$(function() {
  var ua = navigator.userAgent.toLowerCase();
  var isMobile = /iphone/.test(ua)||/android(.+)?mobile/.test(ua);

  if (!isMobile) {
    $('a[href^="tel:"]').css('color', 'inherit');
    $('a[href^="tel:"]').on('click', function (e) {
      e.preventDefault();
    });
  }
});

$(function() {
  $('#slider-nav').append($('#slider').contents().clone());

  $('#slider').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '#slider-nav'
  });
  $('#slider-nav').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    asNavFor: '#slider',
    dots: true,
    centerMode: true,
    focusOnSelect: true
  });
});
