module CreditCardHelper

  def exp_year_range
    ( Time.now.year..Time.now.year + 20 ).map { | num | num.to_s }
  end

  def exp_month_range
    (1..12).map {|num| "%#02d" % num }
  end

end
