require 'rails_helper'

RSpec.describe "Admin::Enquetes", type: :request do
  describe "GET /admin_enquetes" do
    it "works! (now write some real specs)" do
      get admin_enquetes_path
      expect(response).to have_http_status(200)
    end
  end
end
