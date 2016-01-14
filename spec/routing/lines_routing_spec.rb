require "rails_helper"

RSpec.describe LinesController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/lines/1").to route_to("lines#show", :id => "1")
    end

  end
end
