# frozen_string_literal: true

module Fipc
  class CompanyTickers
    # Accept a JSON object containing company CIK data, and build two types of
    # hashes. First type has items whose key is the ticker symbol and value is
    # the CIK. Second type has items whose key is the company name and value is
    # the CIK.
    #
    # Examples of the two hash types:
    # { "AAPL" => 320193, "MSFT" => 789019, ... }
    # { "Apple Inc." => 320193, "MICROSOFT CORP" => 789019, ... }
    class HashBuilder
      # For both +.ticker_hash+ and +.nam_hash+, raw_edgar_json is expected to
      # have a JSON structure like so:
      # {
      #   "0": { "cik_str": 123, "ticker": "ABC", "title": "Abc Inc" },
      #   ...
      # }
      class << self
        # Produce a hash of items whose key is the company ticker symbol, and
        # the value is the company CIK. The key is a string, and the value is
        # an integer.
        def ticker_hash(raw_edgar_json)
          raw_edgar_json.each_with_object({}) do |(_, company), output|
            output[company["ticker"]] = company["cik_str"]
          end
        end

        # Produce a hash of items whose key is the company title, and the valu
        # is the company CIK. The key is a string, and the value is an integer.
        def name_hash(raw_edgar_json)
          raw_edgar_json.each_with_object({}) do |(_, company), output|
            output[company["title"]] = company["cik_str"]
          end
        end
      end
    end
  end
end
