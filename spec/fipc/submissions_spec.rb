# frozen_string_literal: true

require "support/submissions_creator"
require "fipc/submissions"

RSpec.configure do |cfg|
  cfg.include SubmissionsCreator
end

RSpec.describe Fipc::Submissions do
  describe "#fetch_all" do
    let!(:user_agent) { "Foo Bar foobar@example.com" }
    let!(:file_path) { "spec/samples/submissions/zip/submissions.zip" }
    subject(:submissions) { described_class.new(user_agent) }

    before do
      ciks = instance_double(Fipc::Cik, ticker_to_cik: { "AAA" => 11111, "BBB" => 22222 })
      allow(Fipc::Cik).to receive(:new).and_return(ciks)

      write_sample_submissions
      create_zipfile
    end

    it "updates @submissions with the latest" do
      latest_submissions = {
        "AAA" => {
          cik: "11111",
          name: "AAA INC",
          ticker: "AAA",
          industry: "Sample Industry",
          market_cap: "Large"
        },
        "BBB" => {
          cik: "22222",
          name: "BBB CO",
          ticker: "BBB",
          industry: "Another Sample Industry",
          market_cap: "Large"
        }
      }

      allow(described_class::Downloader)
        .to receive(:download)
        .with(user_agent: user_agent, file_path: file_path)

      result = submissions.fetch_all(file_path)

      expect(result).to eq(latest_submissions)
    end
  end
end
