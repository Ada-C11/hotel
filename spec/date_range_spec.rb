require_relative "spec_helper"

describe "DateRange class" do
  describe "valid_date? method" do
    it "raises an error for an invalid date" do
      @date_range = Hotel::DateRange.new("219-1-1", "2019-1-10")

      expect { Date.valid_date?(@date_range) }.must_raise ArgumentError
    end
  end
end
