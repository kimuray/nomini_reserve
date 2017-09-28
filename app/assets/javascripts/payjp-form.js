(function() {
  var form = $("#new_payment"),
      number = form.find('input[name="number"]'),
      cvc = form.find('input[name="cvc"]'),
      exp_month = form.find('select[name="exp_month"]'),
      exp_year = form.find('input[name="exp_year"]');
      ccname = form.find('input[name="ccname"]');
  $("#charge-form").submit(function() {
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: number.value,
        cvc: cvc.value,
        exp_month: exp_month.value,
        exp_year: exp_year.value,
        name: ccname.value
    };
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        form.find('.payment-errors').text(response.error.message);
        form.find('button').prop('disabled', false);
      }
      else {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");
        $(".ccname").removeAttr("name");
        var token = response.id;
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      }
    });
  });
})();
