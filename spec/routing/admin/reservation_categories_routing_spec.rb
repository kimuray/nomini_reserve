require "rails_helper"

RSpec.describe Admin::ReservationCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/reservation_categories").to route_to("admin/reservation_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/reservation_categories/new").to route_to("admin/reservation_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/reservation_categories/1").to route_to("admin/reservation_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/reservation_categories/1/edit").to route_to("admin/reservation_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/reservation_categories").to route_to("admin/reservation_categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/reservation_categories/1").to route_to("admin/reservation_categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/reservation_categories/1").to route_to("admin/reservation_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/reservation_categories/1").to route_to("admin/reservation_categories#destroy", :id => "1")
    end

  end
end
