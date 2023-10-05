# frozen_string_literal: true

require "fipc/cik"

RSpec.describe Fipc::Cik do
  describe "cik_for_ticker" do
    let!(:requester_name) { "Foo Bar" }
    let!(:requester_email) { "foobar@example.com" }

    context "when the ticker is a key in the ticker-to-cik hash" do
      subject(:cik) { described_class.new(requester_name, requester_email) }

      it "returns the CIK" do
        result = cik.cik_for_ticker("AAPL")
        expect(result).to eq(320_193)
      end
    end

    context "when the ticker is not a key in the ticker-to-cik hash" do
      subject(:cik) { described_class.new(requester_name, requester_email) }

      it "returns -1 to indicate the ticker is not a key" do
        result = cik.cik_for_ticker("APPLE")
        expect(result).to eq(-1)
      end
    end
  end
end
