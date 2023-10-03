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
  end
end

require "fipc/submissions/parser"
