# frozen_string_literal: true

module Fipc
  class Cik
    # Utility functions for working with CIK numbers.
    # Example:
    #   Pad a CIK with zeros to use in EDGAR API endpoints.
    class Utility
      class << self
        def correct_format(cik)
          cik = cik.to_s
          return nil if cik.length > 10

          (10 - cik.length).times.inject(cik.to_s) do |padded_cik, _|
            "0#{padded_cik}"
          end
        end
      end
    end
  end
end
