# frozen_string_literal: true

module Fipc
  # This class provides the CIKs of all companies listed on the SEC's
  # company_tickers.json file. All CIKs can be fetched at once, or a company
  # ticker symbol or title can be given to fetch a single CIK.
  # The source file is located at:
  # https://www.sec.gov/files/company_tickers.json
  class Cik
    attr_reader :ticker_to_cik

    def initialize
      company_tickers_json = Downloader.full_list
      @ticker_to_cik = create_ticker_to_cik(company_tickers_json)
    end

    def cik_for_ticker(ticker)
      @ticker_to_cik.key?(ticker) ? @ticker_to_cik[ticker] : -1
    end

    private

    def create_ticker_to_cik(company_tickers_json)
      if Validator.validate(company_tickers_json)
        HashBuilder.ticker_to_cik(company_tickers_json)
      else
        { failure_message: "company_tickers.json validation failed",
          company_tickers_json: company_tickers_json }
      end
    end
  end
end

require "fipc/cik/downloader"
require "fipc/cik/hash_builder"
require "fipc/cik/validator"
