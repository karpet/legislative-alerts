require 'rails_helper'

RSpec.describe Alert, type: :model do
  describe "#check" do
    let(:alert) { create(:search_alert, query: { q: "digital", state: "KS" }.to_json) }

    it "writes checksum before/after + diff" do
      alert.check

      expect(Rails.cache.fetch("alert-#{alert.id}-#{alert.checksum}")).to_not be_nil
      expect(Rails.cache.fetch("alert-#{alert.id}-#{alert.checksum}-diff")).to_not be_nil
    end
  end
end
