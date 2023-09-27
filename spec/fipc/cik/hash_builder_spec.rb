# frozen_string_literal: true

require "support/custom_matchers/be_valid_ticker_hash"
require "support/custom_matchers/be_valid_title_hash"

require "fipc/cik/hash_builder"

RSpec.describe Fipc::Cik::HashBuilder do
  let!(:sample_edgar_json) do
    {
      "0" => { "cik_str" => 320_193, "ticker" => "AAPL", "title" => "Apple Inc." },
      "1" => { "cik_str" => 789_019, "ticker" => "MSFT", "title" => "MICROSOFT CORP" },
      "2" => { "cik_str" => 1_652_044, "ticker" => "GOOGL", "title" => "Alphabet Inc." }
    }
  end

  describe ".ticker_hash" do
    it "returns a hash of items with ticker symbol as key and CIK as value" do
      ticker_to_cik = described_class.ticker_hash sample_edgar_json
      expect(ticker_to_cik).to be_valid_ticker_hash
    end
  end

  describe ".title_hash" do
    it "returns a hash of items with company name as key and CIK as value" do
      name_to_cik = described_class.title_hash sample_edgar_json
      expect(name_to_cik).to be_valid_title_hash
    end
  end
end
