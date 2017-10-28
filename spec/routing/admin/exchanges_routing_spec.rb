require "rails_helper"

RSpec.describe Admin::ExchangesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/exchanges").to route_to("admin/exchanges#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/exchanges/new").to route_to("admin/exchanges#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/exchanges/1").to route_to("admin/exchanges#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/exchanges/1/edit").to route_to("admin/exchanges#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/exchanges").to route_to("admin/exchanges#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/exchanges/1").to route_to("admin/exchanges#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/exchanges/1").to route_to("admin/exchanges#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/exchanges/1").to route_to("admin/exchanges#destroy", :id => "1")
    end

  end
end
