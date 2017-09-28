FactoryGirl.define do
  factory :payment do
    user nil
    status 1
    token_id "MyString"
    customer_id "MyString"
    subscription_id "MyString"
  end
end
