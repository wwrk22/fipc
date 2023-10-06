# frozen_string_literal: true

require "fipc/cik/downloader"

require "api_user_creds"

RSpec.describe Fipc::Cik::Downloader do
  describe ".full_list" do
    RSpec::Matchers.define :be_valid_edgar_data do |_|
      match do |actual_json|
        actual_json.is_a?(Hash) &&
          actual_json.each_value.all? do |entity|
            entity.key?("cik_str") &&
              entity.key?("ticker") &&
              entity.key?("title")
          end
      end
    end

    subject(:cik_json) { described_class.full_list(api_user_name, api_user_email) }

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
