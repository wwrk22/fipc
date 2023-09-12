# frozen_string_literal: true

require "fipc/cik"

RSpec.describe Fipc::Cik::HashBuilder do
  describe ".ticker_hash" do
    RSpec::Matchers.define :be_valid_ticker_hash do |_|
      match do |actual_ticker_hash|
        # My knowledge of the restrictions on ticker symbol naming is limited.
        # For now, I'll test that the abbreviations are all capitalized
        # alphabet characters, and that the CIKs are all integers.
        actual_ticker_hash.all? do |ticker, cik|
          ticker.each_char.all? { |ch| ch.ord >= 65 && ch.ord <= 90 } &&
            cik.is_a?(Integer)
        end
      end
    end

    let!(:sample_edgar_json) do
      {
        "0" => { "cik_str" => 320_193, "ticker" => "AAPL", "title" => "Apple Inc." },
        "1" => { "cik_str" => 789_019, "ticker" => "MSFT", "title" => "MICROSOFT CORP" },
        "2" => { "cik_str" => 1_652_044, "ticker" => "GOOGL", "title" => "Alphabet Inc." }
      }
    end

    it "returns a hash of items with ticker symbol as key and CIK as value" do
      ticker_to_cik = described_class.ticker_hash sample_edgar_json
      expect(ticker_to_cik).to be_valid_ticker_hash
    end
  end

  describe ".name_hash" do
  end
end
