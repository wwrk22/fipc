# frozen_string_literal: true

require "fipc/cik/sample_company_tickers"
require "fipc/cik"

RSpec.describe Fipc::Cik do
  describe "cik_for_ticker" do
    let!(:requester_name) { "Foo Bar" }
    let!(:requester_email) { "foobar@example.com" }

    context "when the ticker is a key in the ticker-to-cik hash" do
      subject(:cik) { described_class.new(requester_name, requester_email) }

      it "returns the CIK" do
        aapl_ticker = SampleCompanyTickers::AAPL.values.first["ticker"]
        aapl_cik = SampleCompanyTickers::AAPL.values.first["cik_str"]
        result = cik.cik_for_ticker(aapl_ticker).to_i
        expect(result).to eq(aapl_cik)
      end
    end

    context "when the ticker is not a key in the ticker-to-cik hash" do
      subject(:cik) { described_class.new(requester_name, requester_email) }

      it "returns -1 to indicate the ticker is not a key" do
        result = cik.cik_for_ticker("BADTICKER")
        expect(result).to eq(-1)
      end
    end
  end
end
