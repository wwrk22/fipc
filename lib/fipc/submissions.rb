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
    attr_accessor :user_agent

    def initialize(user_agent = nil)
      @ciks = Cik.new.ticker_to_cik.values
      @submissions = {}
      @user_agent = user_agent
    end

    def fetch_all(file_path = Downloader::NEW_SUBMISSIONS_FILE_PATH)
      Downloader.download(user_agent: @user_agent, file_path: file_path)
      @submissions.clear

      Zip::File.open(file_path) do |zip|
        zip.each do |entry|
          cik = entry.name[3..12].to_i

          if entry.name =~ /CIK[0-9]{10}\.json/ && @ciks.include?(cik)
            parsed_content = Parser.parse(entry.get_input_stream.read)
            @submissions[parsed_content[:ticker]] = parsed_content
          end
        end
      end

      @submissions
    end
  end
end

require "fipc/submissions/downloader"
require "fipc/submissions/parser"
