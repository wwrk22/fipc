# frozen_string_literal: true

require "net/http"

module Fipc
  class Submissions
    # Download and save the submissions.zip file to disk.
    # The file is fetched from the SEC's EDGAR API at the following endpoint.
    # https://www.sec.gov/Archives/edgar/daily-index/bulkdata/submissions.zip
    class Downloader
      SUBMISSIONS_URL = "https://www.sec.gov/Archives/edgar/daily-index/bulkdata/submissions.zip"
      USER_AGENT_KEY = "User-Agent"
      NEW_SUBMISSIONS_FILE_PATH = "./sec_data/submissions.zip"

      class << self
        def download(user_agent:, file_path: nil)
          result = { response: nil, file_path: file_path }
          fetch(user_agent, result)
          save(result) if result[:response].is_a?(Net::HTTPSuccess)
          result
        end

        private

        def fetch(user_agent, result)
          headers = { USER_AGENT_KEY => user_agent }
          response = Net::HTTP.get_response(URI(SUBMISSIONS_URL), headers)
          result[:response] = response
        end

        def save(result)
          delete_existing_submissions(result)

          file_size = File.open(NEW_SUBMISSIONS_FILE_PATH, "w") do |new_file|
            new_file.write(result[:response].body)
          end

          result[:file_path] = NEW_SUBMISSIONS_FILE_PATH if file_size > 0
        end

        def delete_existing_submissions(result)
          File.delete("./sec_data/submissions.zip")
        rescue SystemCallError => e # common case will give us Errno::ENOENT
          result[:delete_file_error] = e
        end
      end
    end
  end
end
