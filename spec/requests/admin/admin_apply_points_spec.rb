require 'rails_helper'

RSpec.describe "Admin::ApplyPoints", type: :request do
  describe "GET /admin_apply_points" do
    it "works! (now write some real specs)" do
      get admin_apply_points_path
      expect(response).to have_http_status(200)
    end
  end
end
