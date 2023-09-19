# frozen_string_literal: true

require "json"
require "fipc/company_tickers/validator"

RSpec.describe Fipc::CompanyTickers::Validator do
  describe ".validate_keys" do
    context "when valid data is given" do
      it "returns true for all validations" do
        results = []
        samples_dir = Dir.new "spec/samples/company_tickers/valid/keys"
        samples_dir.each_child do |filename|
          file = File.new "#{samples_dir.path}/#{filename}"
          json = JSON.parse file.read
          results << described_class.validate_keys(json)
        end

        expect(results).not_to include(false)
      end
    end

    context "when invalid data is given" do
      it "returns false for all validations" do
        results = []
        samples_dir = Dir.new "spec/samples/company_tickers/invalid/keys"
        samples_dir.each_child do |filename|
          file = File.new "#{samples_dir.path}/#{filename}"
          json = JSON.parse file.read
          results << described_class.validate_keys(json)
        end

        expect(results).not_to include(true)
      end
    end
  end
end
