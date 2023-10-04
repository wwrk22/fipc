# frozen_string_literal: true

require "json"

module Fipc
  class Cik
    # Validate the contents of the SEC's company_tickers.json file. The JSON
    # data is expected to have been parsed and given to this class as a hash.
    class Validator
      VALID_VALUE_KEYS = ["cik_str", "ticker", "title"].freeze
      class << self
        # Validate the top-level keys by checking that:
        # 1. first key is "0"
        # 2. number of items matches what the first and last keys indicate
        def validate_keys(json)
          first_key = json.keys.first.to_s.to_i
          last_key = json.keys.last.to_s.to_i
          first_key.zero? && json.size == (last_key - first_key + 1)
        end

        def validate_entry_value_keys(company_tickers_json)
          company_tickers_json.all? do |entry|
            missing_keys = VALID_VALUE_KEYS.difference(entry[1].keys)
            extra_keys = entry[1].keys.difference(VALID_VALUE_KEYS)
            missing_keys.size.zero? && extra_keys.size.zero?
          end
        end

        def validate_entry_order(company_tickers_json)
          company_tickers_json.each_cons(2).all? do |entry_a, entry_b|
            entry_b[0].to_i == entry_a[0].to_i + 1
          end
        end
      end
    end
  end
end
