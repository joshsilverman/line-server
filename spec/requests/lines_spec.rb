require 'rails_helper'

RSpec.describe "Lines", type: :request do
  let(:valid_attributes) { { "text" => "word", "number" => 1 } }

  describe "GET /lines/123" do
    it "shows an object as json with status 200" do
      line = Line.create! valid_attributes
      get "/lines/#{line.id}.json"
      expect(response).to have_http_status(200)
    end

    it "returns 400 if request invalid" do
      get "/lines/123.json"
      expect(response).to have_http_status(404)
    end
  end
end
