# frozen_string_literal: true

class BeValidTitleHash
  def description
    "be a valid title-to-CIK hash"
  end

  def matches?(actual_hash)
    actual_hash.each_value.all? do |cik|
      cik.is_a? Integer
    end
  end
end

def be_valid_title_hash
  BeValidTitleHash.new
end
