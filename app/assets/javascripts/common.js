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
