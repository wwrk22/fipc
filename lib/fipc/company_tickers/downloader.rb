# frozen_string_literal: true

require "json"
require "net/http"

module Fipc
  class CompanyTickers
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
        def cik_list
          uri = URI("https://www.sec.gov/files/company_tickers.json")
          json = Net::HTTP.get(uri)
          JSON.parse(json)
        end
      end
    end
  end
end
