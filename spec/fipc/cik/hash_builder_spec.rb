# frozen_string_literal: true

require "support/custom_matchers/be_valid_ticker_to_cik"

require "fipc/cik/hash_builder"

RSpec.describe Fipc::Cik::HashBuilder do
  let!(:sample_edgar_json) do
    {
      "0" => { "cik_str" => 320_193, "ticker" => "AAPL", "title" => "Apple Inc." },
      "1" => { "cik_str" => 789_019, "ticker" => "MSFT", "title" => "MICROSOFT CORP" },
      "2" => { "cik_str" => 1_652_044, "ticker" => "GOOGL", "title" => "Alphabet Inc." }
    }
  end

  describe ".ticker_to_cik" do
    it "returns a hash of items with ticker symbol as key and CIK as value" do
      ticker_to_cik = described_class.ticker_to_cik sample_edgar_json
      expect(ticker_to_cik).to be_valid_ticker_to_cik
    end
  end
end
