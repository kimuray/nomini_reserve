require 'rails_helper'

RSpec.describe "Admin::Reservations", type: :request do
  describe "GET /admin_reservations" do
    it "works! (now write some real specs)" do
      get admin_reservations_path
      expect(response).to have_http_status(200)
    end
  end
end
