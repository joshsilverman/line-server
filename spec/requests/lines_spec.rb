require 'rails_helper'

RSpec.describe "Lines", type: :request do
  let(:valid_attributes) { { "text" => "word", "number" => 1 } }

  describe "GET /lines/123" do
    it "shows an object" do
      line = Line.create! valid_attributes
      get "/lines/#{line.id}.json"
      expect(response).to have_http_status(200)
    end
  end
end
