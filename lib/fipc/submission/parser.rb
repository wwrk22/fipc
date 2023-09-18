# frozen_string_literal: true

module Fipc
  class Submission
    class Parser
      class << self
        def parse(raw_submission)
          output = {}
          output[:cik] = raw_submission["cik"]
          output[:name] = raw_submission["name"]
          output[:ticker] = raw_submission["tickers"][0]
          output[:industry] = raw_submission["sicDescription"]
          output[:market_cap] = raw_submission["category"].split[0]
          output
        end
      end
    end
  end
end
