# frozen_string_literal: true

require "fipc/cik/utility"

module Fipc
  class Cik
    # Accept a JSON object containing company CIK data, and build two types of
    # hashes. First type has items whose key is the ticker symbol and value is
    # the CIK. Second type has items whose key is the company name and value is
    # the CIK.
    #
    # Examples of the two hash types:
    # { "AAPL" => 320193, "MSFT" => 789019, ... }
    # { "Apple Inc." => 320193, "MICROSOFT CORP" => 789019, ... }
    class HashBuilder
      # For both +.ticker_to_cik+ and +.title_to_cik+, cik_list is expected to
      # have a JSON structure, as produced by Cik::Downloader, like so:
      # {
      #   "0": { "cik_str": 123, "ticker": "ABC", "title": "Abc Inc" },
      #   ...
      # }
      class << self
        # Produce a hash of items whose key is the company ticker symbol, and
        # the value is the company CIK in zero-padded string format.
        def ticker_to_cik(company_tickers)
          company_tickers.values.reduce({}) do |output, company|
            formatted_cik = Utility.correct_format(company["cik_str"])
            output[company["ticker"]] = formatted_cik
            output
          end
        end
      end
    end
  end
end
