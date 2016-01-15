require 'rails_helper'

RSpec.describe LinesController, type: :controller do
  let(:valid_attributes) { { text: "word", number: 1 } }
  let(:valid_session) { {} }

  describe "GET #show" do
    it "assigns the requested line as @line" do
      line = Line.create! valid_attributes
      get :show, {id: line.to_param, format: :json}, valid_session
      expect(assigns(:line)).to eq(line)
    end

    it "assigns nil if line doesn't exist" do
      get :show, {id: 123, format: :json}, valid_session
      expect(assigns(:line)).to eq(nil)
    end
  end
end
