# frozen_string_literal: true

require 'fipc/cik'


RSpec.describe Fipc::Cik::Downloader do
  describe '.cik_list' do
    RSpec::Matchers.define :be_valid_edgar_data do |_|
      match do |actual_json|
        actual_json.kind_of?(Hash) &&
        actual_json.each_value.all? do |entity|
          entity.has_key?("cik_str") &&
          entity.has_key?("ticker") &&
          entity.has_key?("title")
        end
      end
    end

    subject(:cik_json) { Fipc::Cik::Downloader.cik_list }

    # JSON provided by EDGAR API as of 09-12-2023:
    # {
    #   "0": { "cik_str": 320193, "ticker": "AAPL", "title": "Apple Inc." },
    #   ...
    # }
    # Test that the a value of an item in the hash has the keys "cik_str",
    # "ticker", and "title".
    it "returns a hash of EDGAR data as described in the comment for this example" do
      expect(cik_json).to be_valid_edgar_data
    end
  end
end
