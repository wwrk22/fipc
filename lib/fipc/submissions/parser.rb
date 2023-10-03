# frozen_string_literal: true

module Fipc
  class Submissions
    # Parse a raw submission JSON fetched from the SEC EDGAR submissions API.
    # Produce a hash of selected information from the submission. The raw
    # submission JSON can be fetched by using Fipc::Submission::Fetcher.
    class Parser
      class << self
        def parse(raw_submission)
          { cik: raw_submission["cik"], name: raw_submission["name"],
            ticker: raw_submission["tickers"][0],
            industry: raw_submission["sicDescription"],
            market_cap: raw_submission["category"].split[0] }
        end
      end
    end
  end
end
