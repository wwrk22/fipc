require 'json'
require 'net/http'


module Fipc
  class Cik::Downloader
    class << self
      def cik_list
        uri = URI("https://www.sec.gov/files/company_tickers.json")
        json = Net::HTTP.get(uri)
        JSON.parse(json)
      end
    end
  end
end
