# frozen_string_literal: true

require "fipc/submissions/downloader"

RSpec.describe Fipc::Submissions::Downloader do
  describe ".download" do
    let!(:api_user_name) { "Foo Bar" }
    let!(:api_user_email) { "foobar@example.com" }

    context "when the HTTP request for the file is successful" do
      let!(:ok_response) { Net::HTTPOK.new("HTTP/2", 200, "OK") }

      before do
        allow(ok_response).to receive(:body).and_return("fake zip file content")
        allow(Net::HTTP).to receive(:get_response)
          .with(URI(described_class::SUBMISSIONS_URL),
                { described_class::USER_AGENT_KEY => "#{api_user_name} #{api_user_email}" })
          .and_return(ok_response)
      end

      context "when the file is successfully written to disk" do
        let!(:test_file_size) { 1 }

        it "saves the file and returns a hash of info indicating success" do
          allow(File).to receive(:delete)
            .with(described_class::NEW_SUBMISSIONS_FILE_PATH)
            .and_return(1)
          allow(File).to receive(:open)
            .with(described_class::NEW_SUBMISSIONS_FILE_PATH, "w")
            .and_return(test_file_size)
          expected = { response: ok_response,
                       file_path: "./sec_data/submissions.zip",
                       file_size: test_file_size }

          result = described_class.download(api_user_name: api_user_name,
                                            api_user_email: api_user_email)

          expect(result).to eq(expected)
        end
      end

      context "when a file operation raises a SystemCallError" do
        let!(:expected_error) { Errno::ENOENT.new }

        it "returns a hash of info indicating failure" do
          allow(File).to receive(:exist?)
            .with(described_class::NEW_SUBMISSIONS_FILE_PATH)
            .and_return(true)
          allow(File).to receive(:delete)
            .with(described_class::NEW_SUBMISSIONS_FILE_PATH)
            .and_raise(expected_error)
          expected = { response: ok_response,
                       file_path: described_class::NEW_SUBMISSIONS_FILE_PATH,
                       file_error: expected_error }

          result = described_class.download(api_user_name: api_user_name, api_user_email: api_user_email)

          expect(result).to eq(expected)
        end
      end
    end

    context "when the HTTP request for the file fails" do
      it "does not write a file and returns a hash of info indicating failure" do
        not_found_response = Net::HTTPNotFound.new("HTTP/2", 404, "Not Found")
        allow(Net::HTTP).to receive(:get_response)
          .with(URI(described_class::SUBMISSIONS_URL),
                { described_class::USER_AGENT_KEY => "#{api_user_name} #{api_user_email}" })
          .and_return(not_found_response)
        expected = { response: not_found_response,
                     file_path: described_class::NEW_SUBMISSIONS_FILE_PATH }

        result = described_class.download(api_user_name: api_user_name, api_user_email: api_user_email)

        expect(result).to eq(expected)
      end
    end
  end
end
