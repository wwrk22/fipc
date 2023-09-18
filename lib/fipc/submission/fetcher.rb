# frozen_string_literal: true

require "json"
require "net/http"

module Fipc
  class Submission
    # Fetch the JSON-format company submission data from the SEC EDGAR
    # submissions API. The CIK of a company is required for a single submission
    # fetch.
    class Fetcher
      class << self
        def fetch(cik)
          uri = URI("https://data.sec.gov/submissions/CIK#{cik}.json")
          headers = { "user-agent" => "Won Rhim wwrk22@gmail.com" }
          json = Net::HTTP.get(uri, headers)
          JSON.parse(json)
        end
      end
    end
  end
end
