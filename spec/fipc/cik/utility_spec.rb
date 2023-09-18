# frozen_string_literal: true

require "fipc/cik/utility"

RSpec.describe Fipc::Cik::Utility do
  describe ".correct_format" do
    it "returns a CIK with the correct number of zeros padded" do
      cik = String.new "12345"
      exp_cik = "00000#{cik}"

      formatted_cik = described_class.correct_format cik

      expect(formatted_cik).to eq(exp_cik)
    end
  end
end
