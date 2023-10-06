# frozen_string_literal: true

require "support/submissions_creator"
require "fipc/submissions"

require "api_user_creds"

RSpec.configure do |cfg|
  cfg.include SubmissionsCreator
  cfg.include ApiUserCreds
end

RSpec.describe Fipc::Submissions do
  describe "#fetch_all" do
    let!(:file_path) { "spec/samples/submissions/submissions.zip" }

    context "when not using the real submissions from SEC EDGAR" do
      let!(:ticker_to_cik) { { "AAA" => "0000011111", "BBB" => "0000022222" } }
      subject(:submissions) { described_class.new(api_user_name, api_user_email) }

      before do
        ciks = instance_double(Fipc::Cik, ticker_to_cik: ticker_to_cik)
        allow(Fipc::Cik).to receive(:new)
          .with(api_user_name, api_user_email)
          .and_return(ciks)

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
          .with(api_user_name: api_user_name,
                api_user_email: api_user_email,
                file_path: file_path)

        submissions.fetch_all(file_path)

        expect(submissions.submissions).to eq(latest_parsed_submissions)
      end
    end
  end
end
