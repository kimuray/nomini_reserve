$(function () {
  $('.alert-area').mouseover(function(){
    $('.alert-area').hide();
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
    });
    $('#reservation_alacarte').on('click', function () {
      $('#reservation_category_select').removeClass("show");
    });

    // 画面レンダリング時のラジオボタン確認
    if($("#reservation_course").prop('checked')) {
      $('#reservation_category_select').addClass("show");
    }
  }
});
