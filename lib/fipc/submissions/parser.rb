# frozen_string_literal: true

require "json"

require "fipc/cik/utility"

module Fipc
  class Submissions
    # Parse a raw submission JSON fetched from the SEC EDGAR submissions API to
    # produce a hash of selected information from the submission.
    # EDGAR API endpoint: https://data.sec.gov/submissions/CIK##########.json
    class Parser
      class << self
        def parse(raw_submission)
          submission_json = JSON.parse(raw_submission)
          { cik: Cik::Utility.correct_format(submission_json["cik"]),
            entity_type: submission_json["entityType"],
            name: submission_json["name"],
            ticker: submission_json["tickers"][0],
            industry: submission_json["sicDescription"],
            market_cap: submission_json["category"].split[0] }
        end
      end
    end
  end
end
