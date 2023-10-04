# frozen_string_literal: true

require "zip"

module SubmissionsCreator
  def write_sample_submissions
    # Write two sample submissions file CIK0000011111.json and
    # CIK0000022222.json. Overwrite the files if they exist.
    aaa_submission = "{\"cik\":\"11111\",\"sicDescription\":\"Sample Industry\",\"name\":\"AAA INC\",\"tickers\":[\"AAA\"],\"category\":\"Large accelerated filer\"}"
    bbb_submission = "{\"cik\":\"22222\",\"sicDescription\":\"Another Sample Industry\",\"name\":\"BBB CO\",\"tickers\":[\"BBB\"],\"category\":\"Large accelerated filer\"}"
    File.open("spec/samples/submissions/CIK0000011111.json", "w") do
      |f| f.write(aaa_submission)
    end

    File.open("spec/samples/submissions/CIK0000022222.json", "w") do
      |f| f.write(bbb_submission)
    end
  end

  def create_zipfile
    samples_folder = "spec/samples/submissions"
    zipfile_path = "zip/submissions.zip"
    file_names = ["CIK0000011111.json", "CIK0000022222.json"]

    # Remove existing zipfile first to prevent Zip::File::open from raising an
    # error.
    begin
      File.delete("#{samples_folder}/#{zipfile_path}")
    rescue SystemCallError => e
      puts e.message
    end

    Zip::File.open("#{samples_folder}/#{zipfile_path}", create: true) do |zipfile|
      file_names.each do |file_name|
        zipfile.add(file_name, "#{samples_folder}/#{file_name}")
      end
    end
  end
end
