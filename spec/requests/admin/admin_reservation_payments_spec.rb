require 'rails_helper'

RSpec.describe "Admin::ReservationPayments", type: :request do
  describe "GET /admin_reservation_payments" do
    it "works! (now write some real specs)" do
      get admin_reservation_payments_path
      expect(response).to have_http_status(200)
    end
  end
end
