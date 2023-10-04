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
      unprocessed_list = Downloader.full_list
      @ticker_to_cik = Validator.validate(unprocessed_list) ?
        HashBuilder.ticker_to_cik(unprocessed_list) :
        { failure_message: "company_tickers.json validation failed",
          unprocessed_list: unprocessed_list }
    end

    def cik_for_ticker(ticker)
      @ticker_to_cik.key?(ticker) ? @ticker_to_cik[ticker] : -1
    end
  end
end

require "fipc/cik/downloader"
require "fipc/cik/hash_builder"
require "fipc/cik/validator"
