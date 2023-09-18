# frozen_string_literal: true

require "json"
require "fipc/submission"

RSpec.describe Fipc::Submission::Parser do
  describe ".parse" do
    it "returns a processed version of the EDGAR submission JSON" do
      # Use a saved raw submission json in place of one directly fetched from
      # the EDGAR API. The CIK 92380 is for the company of ticker symbol LUV.
      submission_filepath = "spec/samples/raw_submissions/CIK0000092380.json"
      raw_submission = File.open(submission_filepath, &:read)

      # Parse from JSON string to JSON.
      raw_submission = JSON.parse(raw_submission)

      # The output is a selected set of information as defined in the Parser
      # class.
      exp_parsed_submission = {
        cik: "92380",
        name: "SOUTHWEST AIRLINES CO",
        ticker: "LUV",
        industry: "Air Transportation, Scheduled",
        market_cap: "Large"
      }

      parsed_submission = described_class.parse(raw_submission)

      expect(parsed_submission).to eq(exp_parsed_submission)
    end
  end
end
