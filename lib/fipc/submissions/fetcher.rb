# frozen_string_literal: true

require "fipc/cik/utility"

module Fipc
  class Submissions
    # Fetch the JSON-format company submission data from the SEC EDGAR
    # submissions API. The CIK of a company is required for a single submission
    # fetch.
    class Fetcher
      class << self
        def fetch(cik)
          cik = Fipc::Cik::Utility.correct_format(cik)
          endpoint = "https://data.sec.gov/submissions/CIK#{cik}.json"
          EdgarApi.fetch_json(endpoint, "Won Rhim", "wwrk22@gmail.com")
        end
      end
    end
  end
end
