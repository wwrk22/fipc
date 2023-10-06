# frozen_string_literal: true

require "json"
require "open-uri"
require "fipc/cik"
require "fipc/cik/utility"
require "zip"

require "benchmark"

module Fipc
  # Provide condensed versions of public company submission filings by fetching
  # the data from the SEC's EDGAR API.
  class Submissions
    attr_reader :submissions
    attr_accessor :api_user_name, :api_user_email

    def initialize(api_user_name, api_user_email)
      @ciks = Cik.new(api_user_name, api_user_email).ticker_to_cik.values
      @submissions = {}
      @api_user_name = api_user_name
      @api_user_email = api_user_email
    end

    def fetch_all(file_path = Downloader::NEW_SUBMISSIONS_FILE_PATH)
      Downloader.download(api_user_name: @api_user_name,
                          api_user_email: @api_user_email,
                          file_path: file_path)
      @submissions.clear

      Zip::File.open(file_path) do |zip|
        zip.each do |submission|
          process_submission(submission) if company_submission?(submission)
        end
      end
    end

    private

    def process_submission(submission)
      parsed_submission = Parser.parse(submission.get_input_stream.read)
      entity_type = parsed_submission[:entity_type]
      ticker = parsed_submission[:ticker]
      @submissions[ticker] = parsed_submission if entity_type == "operating"
    end

    # Company filings file names seem to follow the format of
    # CIK<10-digit-num>.json.
    def company_submission?(submission)
      cik = submission.name[3..12]
      submission.name =~ /CIK[0-9]{10}\.json/ && @ciks.include?(cik)
    end
  end
end

require "fipc/submissions/downloader"
require "fipc/submissions/parser"
