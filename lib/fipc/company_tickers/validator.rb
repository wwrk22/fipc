# frozen_string_literal: true

module Fipc
  class CompanyTickers
    class Validator
      class << self
        def validate_keys(json)
          keys = json.keys
          first_key, last_key = [keys.first.to_s.to_i, keys.last.to_s.to_i]
          count = last_key - first_key + 1
          return json.size == count
        end
      end
    end
  end
end
