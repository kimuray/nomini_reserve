require 'rails_helper'

RSpec.describe "Admin::Exchanges", type: :request do
  describe "GET /admin_exchanges" do
    it "works! (now write some real specs)" do
      get admin_exchanges_path
      expect(response).to have_http_status(200)
    end
  end
end
