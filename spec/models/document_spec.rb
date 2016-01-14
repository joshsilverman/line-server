require 'rails_helper'

RSpec.describe Document, type: :model do
  it "is findable" do
    filename = 'example filename'
    d = Document.find_or_create_by(filename: filename)
    expect(Document.count).to   eq(1)
  end
end
