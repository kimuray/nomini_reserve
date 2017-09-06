require "rails_helper"

RSpec.describe Admin::ReservationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/reservations").to route_to("admin/reservations#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/reservations/new").to route_to("admin/reservations#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/reservations/1").to route_to("admin/reservations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/reservations/1/edit").to route_to("admin/reservations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/reservations").to route_to("admin/reservations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/reservations/1").to route_to("admin/reservations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/reservations/1").to route_to("admin/reservations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/reservations/1").to route_to("admin/reservations#destroy", :id => "1")
    end

  end
end
