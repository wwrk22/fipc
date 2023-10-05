module SampleCompanyTickers
  AAPL = {
    "0" => {
      "cik_str" => 320_193,
      "ticker" => "AAPL",
      "title" => "Apple Inc."
    }
  }
  MSFT = {
    "1" => {
      "cik_str" => 789_019,
      "ticker" => "MSFT",
      "title" => "MICROSOFT CORP"
    }
  }
  GOOGL = {
    "2" => {
      "cik_str" => 1_652_044,
      "ticker" => "GOOGL",
      "title" => "Alphabet Inc."
    }
  }
  SAMPLE_SET = { **AAPL, **MSFT, **GOOGL }
end
