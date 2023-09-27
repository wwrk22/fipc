# frozen_string_literal: true

require "fipc/cik"

RSpec.describe Fipc::Cik do
  describe "cik_for_ticker" do
    context "when the ticker is a key in the ticker-to-cik hash" do
      subject(:cik) { described_class.new }

      it "returns the CIK" do
        result = cik.cik_for_ticker("AAPL")
        expect(result).to eq(320_193)
      end
    end

    context "when the ticker is not a key in the ticker-to-cik hash" do
      subject(:cik) { described_class.new }

      it "returns -1 to indicate the ticker is not a key" do
        result = cik.cik_for_ticker("APPLE")
        expect(result).to eq(-1)
      end
    end
  end
end
