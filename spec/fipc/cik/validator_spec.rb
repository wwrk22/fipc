# frozen_string_literal: true

require "json"
require "fipc/cik/validator"

require "support/json_processor"

RSpec.configure do |cfg|
  cfg.include JsonProcessor
end

RSpec.describe Fipc::Cik::Validator do
  let!(:valid_samples_dir) { "spec/samples/cik/valid/keys" }

  describe ".validate_keys" do
    let!(:validate) do
      lambda do |company_tickers_json|
        described_class.validate_keys(company_tickers_json)
      end
    end

    context "when valid data is given" do
      it "returns true for all validations" do
        results = process(valid_samples_dir, &validate)
        expect(results).to all(eq(true))
      end
    end

    context "when invalid data is given" do
      it "returns false for all validations" do
        invalid_samples_dir = "spec/samples/cik/invalid/keys"
        results = process(invalid_samples_dir, &validate)
        expect(results).to all(eq(false))
      end
    end
  end

  describe ".validate_entry_value_keys" do
    let!(:validate) do
      lambda do |company_tickers_json|
        described_class.validate_entry_value_keys(company_tickers_json)
      end
    end

    context "when valid data is given" do
      it "returns true" do
        results = process(valid_samples_dir, &validate)
        expect(results).to all(eq(true))
      end
    end

    context "when invalid data is given" do
      it "returns false" do
        invalid_samples_dir = "spec/samples/cik/invalid/invalid_value_keys"
        results = process(invalid_samples_dir, &validate)
        expect(results).to all(eq(false))
      end
    end
  end

  describe ".validate_entry_order" do
    let!(:validate) do
      lambda do |company_tickers_json|
        described_class.validate_entry_order(company_tickers_json)
      end
    end

    context "when valid data is given" do
      it "returns true" do
        results = process(valid_samples_dir, &validate)
        expect(results).to all(eq(true))
      end
    end

    context "when invalid data is given" do
      it "returns false" do
        invalid_samples_dir = "spec/samples/cik/invalid/entry_order"
        results = process(invalid_samples_dir, &validate)
        expect(results).to all(eq(false))
      end
    end
  end
end
