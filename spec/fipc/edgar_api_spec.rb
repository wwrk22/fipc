# frozen_string_literal: true

require "fipc/edgar_api"

RSpec.describe Fipc::EdgarApi do
  describe ".fetch_json" do
    RSpec::Matchers.define :be_valid_data do |expected_data|
      match { |data| data == expected_data }
    end

    context "when a valid JSON data API endpoint is given" do
      subject(:fetched_data) do
        described_class.fetch_json("/placeholder/endpoint",
                                   "Firstname Lastname",
                                   "first.last@example.com")
      end

      let!(:sample_json_str) { "{\"animal\":\"cow\"}" }
      let!(:sample_json_hash) { { "animal" => "cow" } }

      it "fetches then returns ruby hash of the parsed JSON" do
        allow(Net::HTTP).to receive(:get).and_return(sample_json_str)
        expect(fetched_data).to be_valid_data(sample_json_hash)
      end
    end
  end
end
