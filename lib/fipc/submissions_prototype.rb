# frozen_string_literal: true

require "json"
require "open-uri"
require "fipc/cik"
require "fipc/cik/utility"
require "zip"

require "benchmark"

module Fipc
  class Submissions
    SUBMISSIONS_URL = "https://www.sec.gov/Archives/edgar/daily-index/bulkdata/submissions.zip"

    def initialize
      @ciks = Cik.new.ticker_to_cik.values
    end

    def all_submissions
      h = {}

      time = Benchmark.measure do
        Zip::File.open("./sec_data/submissions.zip") do |zip|
          zip.each do |entry|
            cik = entry.name[3..12].to_i

            if entry.name =~ /CIK[0-9]{10}\.json/ && @ciks.include?(cik)
              parsed_content = Parser.parse(entry.get_input_stream.read)
              h[parsed_content[:ticker]] = parsed_content
            end
          end
        end
      end

      puts "time = #{time.real}"
      h
    end

    def all_submissions_url
      submissions = nil
      t1 = Benchmark.measure do
        submissions_url = URI(SUBMISSIONS_URL)
        submissions = submissions_url.open({ "User-Agent" => "Won Rhim wwrk22@gmail.com" })
      end
      puts "t1: #{t1.real}"

      h = {}

      t2 = Benchmark.measure do
        Zip::File.open_buffer(submissions) do |zip|
          zip.each do |entry|
            cik = entry.name[3..12].to_i

            if entry.name =~ /CIK[0-9]{10}\.json/ && @ciks.include?(cik)
              parsed_content = Parser.parse(entry.get_input_stream.read)
              h[parsed_content[:ticker]] = parsed_content
            end
          end
        end
      end
      puts "time = #{t2.real}"
      h
    end

    def submission(cik = 320_193)
      Zip::File.open("./sec_data/submissions.zip") do |zip|
        zip.each do |entry|
          if entry.name =~ /CIK[0-9]{10}\.json/ && entry.name[3..12].to_i == cik
            json = JSON.parse(entry.get_input_stream.read)
            return Parser.parse(json)
          end
        end
      end
    end
  end
end

require "fipc/submissions/parser"