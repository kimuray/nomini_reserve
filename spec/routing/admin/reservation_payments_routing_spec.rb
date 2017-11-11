require "rails_helper"

RSpec.describe Admin::ReservationPaymentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/reservation_payments").to route_to("admin/reservation_payments#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/reservation_payments/new").to route_to("admin/reservation_payments#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/reservation_payments/1").to route_to("admin/reservation_payments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/reservation_payments/1/edit").to route_to("admin/reservation_payments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/reservation_payments").to route_to("admin/reservation_payments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/reservation_payments/1").to route_to("admin/reservation_payments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/reservation_payments/1").to route_to("admin/reservation_payments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/reservation_payments/1").to route_to("admin/reservation_payments#destroy", :id => "1")
    end

  end
end
