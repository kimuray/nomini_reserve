require "rails_helper"

RSpec.describe Admin::EnquetesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/enquetes").to route_to("admin/enquetes#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/enquetes/new").to route_to("admin/enquetes#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/enquetes/1").to route_to("admin/enquetes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/enquetes/1/edit").to route_to("admin/enquetes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/enquetes").to route_to("admin/enquetes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/enquetes/1").to route_to("admin/enquetes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/enquetes/1").to route_to("admin/enquetes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/enquetes/1").to route_to("admin/enquetes#destroy", :id => "1")
    end

  end
end
