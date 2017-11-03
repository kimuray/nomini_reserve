require "rails_helper"

RSpec.describe Admin::ReservationBenefitsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/reservation_benefits").to route_to("admin/reservation_benefits#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/reservation_benefits/new").to route_to("admin/reservation_benefits#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/reservation_benefits/1").to route_to("admin/reservation_benefits#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/reservation_benefits/1/edit").to route_to("admin/reservation_benefits#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/reservation_benefits").to route_to("admin/reservation_benefits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/reservation_benefits/1").to route_to("admin/reservation_benefits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/reservation_benefits/1").to route_to("admin/reservation_benefits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/reservation_benefits/1").to route_to("admin/reservation_benefits#destroy", :id => "1")
    end

  end
end
