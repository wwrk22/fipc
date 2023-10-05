# frozen_string_literal: true

module SampleCompanyTickers
  AAPL = {
    "0" => {
      "cik_str" => 320_193,
      "ticker" => "AAPL",
      "title" => "Apple Inc."
    }
  }.freeze
  MSFT = {
    "1" => {
      "cik_str" => 789_019,
      "ticker" => "MSFT",
      "title" => "MICROSOFT CORP"
    }
  }.freeze
  GOOGL = {
    "2" => {
      "cik_str" => 1_652_044,
      "ticker" => "GOOGL",
      "title" => "Alphabet Inc."
    }
  }.freeze
  SAMPLE_SET = { **AAPL, **MSFT, **GOOGL }.freeze
end
