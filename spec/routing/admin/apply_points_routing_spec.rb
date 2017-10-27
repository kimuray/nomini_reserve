require "rails_helper"

RSpec.describe Admin::ApplyPointsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/apply_points").to route_to("admin/apply_points#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/apply_points/new").to route_to("admin/apply_points#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/apply_points/1").to route_to("admin/apply_points#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/apply_points/1/edit").to route_to("admin/apply_points#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/apply_points").to route_to("admin/apply_points#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/apply_points/1").to route_to("admin/apply_points#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/apply_points/1").to route_to("admin/apply_points#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/apply_points/1").to route_to("admin/apply_points#destroy", :id => "1")
    end

  end
end
