require 'rails_helper'

RSpec.describe "Admin::ReservationCategories", type: :request do
  describe "GET /admin_reservation_categories" do
    it "works! (now write some real specs)" do
      get admin_reservation_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
