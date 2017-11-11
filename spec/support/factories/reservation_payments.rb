FactoryGirl.define do
  factory :reservation_payment do
    user nil
    reservation nil
    payjp_token_id "MyString"
    currency "MyString"
    amount 1
    status 1
  end
end
