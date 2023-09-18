# frozen_string_literal: true

module Fipc
  class Cik
    class Utility
      class << self
        def correct_format(cik)
          # CIK cannot be greater than ten digits.
          # Let's just return nil for now.
          return nil if cik.length > 10

          (10 - cik.length).times.inject(cik) do |padded_cik, _|
            padded_cik.prepend "0"
          end
        end
      end
    end
  end
end
