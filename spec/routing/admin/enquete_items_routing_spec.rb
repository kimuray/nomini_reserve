require "rails_helper"

RSpec.describe Admin::EnqueteItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/enquete_items").to route_to("admin/enquete_items#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/enquete_items/new").to route_to("admin/enquete_items#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/enquete_items/1").to route_to("admin/enquete_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/enquete_items/1/edit").to route_to("admin/enquete_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/enquete_items").to route_to("admin/enquete_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/enquete_items/1").to route_to("admin/enquete_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/enquete_items/1").to route_to("admin/enquete_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/enquete_items/1").to route_to("admin/enquete_items#destroy", :id => "1")
    end

  end
end
