# frozen_string_literal: true

require "fipc/submissions/downloader"

RSpec.describe Fipc::Submissions::Downloader do
  describe ".download" do
    context "when valid user-agent and file path are given" do
      let!(:user_agent) { "Foo Bar foobar@example.com" }

      context "when the HTTP request for the file is successful" do
        it "saves the file and returns a hash of info indicating success" do
          ok_response = Net::HTTPOK.new("HTTP/2", 200, "OK")
          allow(ok_response).to receive(:body).and_return("fake zip file content")
          allow(Net::HTTP).to receive(:get_response)
            .with(URI(described_class::SUBMISSIONS_URL),
                  { described_class::USER_AGENT_KEY => user_agent })
            .and_return(ok_response)
          allow(File).to receive(:delete)
            .with(described_class::NEW_SUBMISSIONS_FILE_PATH)
            .and_return(1)
          allow(File).to receive(:open)
            .with(described_class::NEW_SUBMISSIONS_FILE_PATH, "w")
            .and_return(1)
          expected = { response: ok_response,
                       file_path: "./sec_data/submissions.zip" }

          result = described_class.download(user_agent: user_agent)

          expect(result).to eq(expected)
        end
      end

      context "when the HTTP request for the file fails" do
        it "does not write a file and returns a hash of info indicating failure" do
          not_found_response = Net::HTTPNotFound.new("HTTP/2", 404, "Not Found")
          allow(Net::HTTP).to receive(:get_response)
            .with(URI(described_class::SUBMISSIONS_URL),
                  { described_class::USER_AGENT_KEY => user_agent })
            .and_return(not_found_response)
          expected = { response: not_found_response, file_path: nil }

          result = described_class.download(user_agent: user_agent)

          expect(result).to eq(expected)
        end
      end
    end
  end
end
