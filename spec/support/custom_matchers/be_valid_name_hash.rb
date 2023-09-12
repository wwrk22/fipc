# frozen_string_literal: true

class BeValidNameHash
  def description
    "be a valid name-to-CIK hash"
  end

  def matches?(actual_hash)
    actual_hash.each_value.all? do |cik|
      cik.is_a? Integer
    end
  end
end

def be_valid_name_hash
  BeValidNameHash.new
end
