require 'rails_helper'

RSpec.describe "Admin::Shops", type: :request do
  describe "GET /admin_shops" do
    it "works! (now write some real specs)" do
      get admin_shops_path
      expect(response).to have_http_status(200)
    end
  end
end
