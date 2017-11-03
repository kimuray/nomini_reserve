require 'rails_helper'

RSpec.describe "Admin::ReservationBenefits", type: :request do
  describe "GET /admin_reservation_benefits" do
    it "works! (now write some real specs)" do
      get admin_reservation_benefits_path
      expect(response).to have_http_status(200)
    end
  end
end
