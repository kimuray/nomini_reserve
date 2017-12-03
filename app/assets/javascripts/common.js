$(function () {
  $('.alert-area').mouseover(function(){
    $('.alert-area').hide();
  });

  $('#prefecture').change(function() {
    $.get({
      url: "/cities",
      data: { prefecture_id: $('#prefecture').has('option:selected').val() }
    });
  });
})
