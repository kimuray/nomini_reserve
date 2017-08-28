require "rails_helper"

RSpec.describe Admin::ShopsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/shops").to route_to("admin/shops#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/shops/new").to route_to("admin/shops#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/shops/1").to route_to("admin/shops#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/shops/1/edit").to route_to("admin/shops#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/shops").to route_to("admin/shops#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/shops/1").to route_to("admin/shops#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/shops/1").to route_to("admin/shops#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/shops/1").to route_to("admin/shops#destroy", :id => "1")
    end

  end
end
