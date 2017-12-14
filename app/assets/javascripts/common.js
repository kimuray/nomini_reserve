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
