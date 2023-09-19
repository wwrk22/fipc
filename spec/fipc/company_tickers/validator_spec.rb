# frozen_string_literal: true

require "json"
require "fipc/company_tickers/validator"

require "support/json_processor"

RSpec.configure do |cfg|
  cfg.include JsonProcessor
end

RSpec.describe Fipc::CompanyTickers::Validator do
  describe ".validate_keys" do
    let!(:validate) do
      lambda do |company_tickers_json|
        described_class.validate_keys company_tickers_json
      end
    end

    context "when valid data is given" do
      it "returns true for all validations" do
        samples_dir = "spec/samples/company_tickers/valid/keys"
        results = process(samples_dir, &validate)

        expect(results).to all(eq(true))
      end
    end

    context "when invalid data is given" do
      it "returns false for all validations" do
        samples_dir = "spec/samples/company_tickers/invalid/keys"
        results = process(samples_dir, &validate)

        expect(results).to all(eq(false))
      end
    end
  end
end
