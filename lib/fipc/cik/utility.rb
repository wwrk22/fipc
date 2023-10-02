# frozen_string_literal: true

module Fipc
  class Cik
    # Utility functions for working with CIK numbers.
    # Example:
    #   Pad a CIK with zeros to use in EDGAR API endpoints.
    class Utility
      class << self
        def correct_format(cik, cik_str = cik.to_s)
          # CIK cannot be greater than ten digits.
          # Let's just return nil for now.
          return nil if cik_str.length > 10

          (10 - cik_str.length).times.inject(String.new(cik_str)) do |padded_cik, _|
            padded_cik = "0" + padded_cik
          end
        end
      end
    end
  end
end
