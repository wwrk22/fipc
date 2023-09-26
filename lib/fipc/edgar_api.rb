# frozen_string_literal: true

require "json"
require "net/http"

module Fipc
  # Fetch data from SEC's EDGAR API by providing the endpoints.
  class EdgarApi
    class << self
      def fetch_json(endpoint, full_name, email)
        headers = { "user-agent" => "#{full_name} #{email}" }
        json = Net::HTTP.get(URI(endpoint), headers)
        JSON.parse(json)
      end
    end
  end
end
