# frozen_string_literal: true

module Fipc
  # Fetch data from SEC's EDGAR API by providing the endpoints.
  class EdgarApi
    class << self
      def fetch_json(endpoint)
        headers = { "user-agent" => "Won Rhim wwrk22@gmail.com" }
        json = Net::HTTP.get(URI(endpoint), headers)
        JSON.parse(json)
      end
    end
  end
end
