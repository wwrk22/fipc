# frozen_string_literal: true

class BeValidTickerHash
  def description
    "be a valid ticker-to-CIK hash"
  end

  def matches?(actual_hash)
    # My knowledge of the restrictions on ticker symbol naming is limited.
    # For now, I'll test that the abbreviations are all capitalized
    # alphabet characters, and that the CIKs are all integers.
    actual_hash.all? do |ticker, cik|
      ticker.each_char.all? { |ch| ch.ord >= 65 && ch.ord <= 90 } &&
        cik.is_a?(Integer)
    end
  end
end

def be_valid_ticker_hash
  BeValidTickerHash.new
end
