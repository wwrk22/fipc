# frozen_string_literal: true

require "fipc/company_tickers/validator"

RSpec.describe Fipc::CompanyTickers::Validator do
  describe ".validate_company_tickers" do
    it "validates the SEC EDGAR's company_tickers.json contents" do
      expect(result).to eq(true)
    end
  end
end
