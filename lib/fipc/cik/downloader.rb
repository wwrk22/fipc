# frozen_string_literal: true

require "fipc/edgar_api"

module Fipc
  class Cik
    # Download the company_tickers.json file from SEC's EDGAR API to produce a ruby
    # hash from the JSON.
    #
    # JSON structure:
    # {
    #   "0": { "cik_str": 320193, "ticker": "AAPL", "title": "Apple Inc." },
    #   ...
    # }
    class Downloader
      class << self
        def full_list
          endpoint = "https://www.sec.gov/files/company_tickers.json"
          EdgarApi.fetch_json(endpoint, "Won Rhim", "wwrk22@gmail.com") # hardcoded
        end
      end
    end
  end
end
