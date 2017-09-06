require 'rails_helper'

RSpec.describe "Admin::EnqueteItems", type: :request do
  describe "GET /admin_enquete_items" do
    it "works! (now write some real specs)" do
      get admin_enquete_items_path
      expect(response).to have_http_status(200)
    end
  end
end
