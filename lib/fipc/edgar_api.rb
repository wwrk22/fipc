module Fipc
  class EdgarApi
    class << self
      def fetch(endpoint)
        headers = { "user-agent" => "Won Rhim wwrk22@gmail.com" }
        json = Net::HTTP.get(URI(endpoint), headers)
        JSON.parse(json)
      end
    end
  end
end
