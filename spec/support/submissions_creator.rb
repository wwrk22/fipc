# frozen_string_literal: true

require "zip"

module SubmissionsCreator
  SAMPLES_FOLDER = "spec/samples/submissions"
  ZIPFILE_PATH = "zip/submissions.zip"
  FILE_NAMES = ["CIK0000011111.json", "CIK0000022222.json"].freeze

  def latest_submissions
    { "AAA" => { cik: "11111", name: "AAA INC", ticker: "AAA",
                 industry: "Sample Industry", market_cap: "Large" },
      "BBB" => { cik: "22222", name: "BBB CO", ticker: "BBB",
                 industry: "Another Sample Industry", market_cap: "Large" } }
  end

  def write_sample_submissions
    # Write two sample submissions file CIK0000011111.json and
    # CIK0000022222.json. Overwrite the files if they exist.
    File.open("spec/samples/submissions/CIK0000011111.json", "w") do |f|
      f.write(aaa_submission)
    end

    File.open("spec/samples/submissions/CIK0000022222.json", "w") do |f|
      f.write(bbb_submission)
    end
  end

  def create_zipfile
    Zip::File.open("#{SAMPLES_FOLDER}/#{ZIPFILE_PATH}", create: true) do |zipfile|
      FILE_NAMES.each do |file_name|
        zipfile.add(file_name, "#{SAMPLES_FOLDER}/#{file_name}")
      end
    end
  end

  def delete_zipfile
    File.delete("#{SAMPLES_FOLDER}/#{ZIPFILE_PATH}")
  rescue SystemCallError => e
    puts e.message
  end

  private

  def aaa_submission
    cik = "\"cik\":\"11111\""
    sic_description = "\"sicDescription\":\"Sample Industry\""
    name = "\"name\":\"AAA INC\""
    tickers = "\"tickers\":[\"AAA\"]"
    category = "\"category\":\"Large accelerated filer\""
    "{#{cik},#{sic_description},#{name},#{tickers},#{category}}"
  end

  def bbb_submission
    cik = "\"cik\":\"22222\""
    sic_description = "\"sicDescription\":\"Another Sample Industry\""
    name = "\"name\":\"BBB CO\""
    tickers = "\"tickers\":[\"BBB\"]"
    category = "\"category\":\"Large accelerated filer\""
    "{#{cik},#{sic_description},#{name},#{tickers},#{category}}"
  end
end
