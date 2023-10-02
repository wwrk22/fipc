# frozen_string_literal: true

require "fipc/submissions/downloader"

RSpec.describe Fipc::Submissions::Downloader do
#  describe ".download" do
#    context "when HTTP request for file succeeds" do
#      it "writes the file content to a new zip file" do
#        expected_result = { code: 200, filepath: "./sec_data/submissions.zip" }
#        result = described_class.download("Won Rhim wwrk22@gmail.com")
#        expect(result).to eq(expected_result)
#      end
#    end
#
#    context "when HTTP request for file fails" do
#      it "does not write a file and immediately returns false" do
#      end
#    end
#  end

  describe ".download" do
    context "when valid user-agent and file path are given" do
      context "when the HTTP request for the file is successful" do
        it "saves the file and returns a hash of info indicating success" do
          user_agent = "Foo Bar foobar@example.com"
          success_response = instance_double(Net::HTTPSuccess,
                                             :code => 200,
                                             :body => "fake zip file content")
          allow(Net::HTTP).to receive(:get_response).
            with(URI(described_class::SUBMISSIONS_URL),
                 { described_class::USER_AGENT_KEY => user_agent}).
            and_return(success_response)
          allow(File).to receive(:delete).
            with(described_class::NEW_SUBMISSIONS_FILE_PATH).
            and_return(1)
          allow(File).to receive(:open).
            with(described_class::NEW_SUBMISSIONS_FILE_PATH, 'w').
            and_return(1)

          expected_result = { response: success_response,
                              file_path: "./sec_data/submissions.zip" }

          result = described_class.download(user_agent: user_agent)

          expect(result).to eq(expected_result)
        end
      end
    end
  end
end
