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
    let!(:ticker_to_cik) { { "AAA" => 11_111, "BBB" => 22_222 } }
    subject(:submissions) { described_class.new(user_agent) }

    before do
      ciks = instance_double(Fipc::Cik, ticker_to_cik: ticker_to_cik)
      allow(Fipc::Cik).to receive(:new).and_return(ciks)

      write_sample_submissions
      create_zipfile
    end

    after do
      delete_zipfile
    end

    it "updates the Submissions object with latest SEC filing data" do
      # We're using a submissions.zip created by support library, so we
      # intentionally make `.download` do nothing.
      allow(described_class::Downloader)
        .to receive(:download)
        .with(user_agent: user_agent, file_path: file_path)

      submissions.fetch_all(file_path)

      expect(submissions.submissions).to eq(latest_submissions)
    end
  end
end
