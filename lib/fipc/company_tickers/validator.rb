# frozen_string_literal: true

module Fipc
  class CompanyTickers
    # Validate the contents of the SEC's company_tickers.json file. The JSON
    # data is expected to have been parsed and given to this class as a hash.
    class Validator
      class << self
        # Validate the top-level keys by checking that:
        # 1. first key is "0"
        # 2. number of items matches what the first and last keys indicate
        def validate_keys(json)
          first_key = json.keys.first.to_s.to_i
          last_key = json.keys.last.to_s.to_i
          first_key.zero? && json.size == (last_key - first_key + 1)
        end
      end
    end
  end
end
