# frozen_string_literal: true

require "fipc/edgar_api"
require "fipc/sec_edgar/endpoints"

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
          EdgarApi.fetch_json(SecEdgar::Endpoints::COMPANY_TICKERS_JSON,
                              "Won Rhim",
                              "wwrk22@gmail.com")
        end
      end
    end
  end
end
