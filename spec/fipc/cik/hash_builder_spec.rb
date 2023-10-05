# frozen_string_literal: true

require "support/custom_matchers/be_valid_ticker_to_cik"
require "fipc/cik/sample_company_tickers"

require "fipc/cik/hash_builder"

RSpec.describe Fipc::Cik::HashBuilder do
  describe ".ticker_to_cik" do
    it "returns a hash of items with ticker symbol as key and CIK as value" do
      ticker_to_cik = described_class.ticker_to_cik(SampleCompanyTickers::SAMPLE_SET)
      expect(ticker_to_cik).to be_valid_ticker_to_cik
    end
  end
end
