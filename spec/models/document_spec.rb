require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:filename) { 'spec/fixtures/sample-2lines.txt' }
  let(:document) { Document.create(filename: filename) }

  describe "#preprocess" do
    it "creates 2 lines for document" do
      document.preprocess
      expect(document.lines.count).to eq(2)
    end

    it "wont recreate lines if reprocessed" do
      document.preprocess
      document.preprocess
      expect(document.lines.count).to eq(2)
    end

    it "properly creates foreign keys (for sql version)" do
      document.preprocess
      # strange rspec-ism: I had to put #all in there
      expect(document.lines.all.first.document_id).to eq(document.id)
    end
  end
end
