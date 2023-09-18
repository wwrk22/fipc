# frozen_string_literal: true

require "fipc/submission"

RSpec.describe Fipc::Submission::Fetcher do
  describe ".fetch" do
    RSpec::Matchers.define :be_valid_submission do |_|
      match do |submission|
        submission.key?("cik") && submission.key?("entityType") &&
          submission.key?("sic") && submission.key?("sicDescription")
      end
    end

    subject(:submission) { described_class.fetch("0000092380") }

    it "returns a hash representing the JSON submission fetched for the given CIK" do
      expect(submission).to be_valid_submission
    end
  end
end
