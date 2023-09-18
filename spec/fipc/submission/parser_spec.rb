# frozen_string_literal: true

require "fipc/submission"

RSpec.describe Fipc::Submission::Parser do 
  describe ".parse" do
    it "returns a slimmed-down version of the EDGAR submission JSON" do
      raw_submission = Fipc::Submission::Fetcher.fetch("0000092380")
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
