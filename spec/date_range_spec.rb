require_relative "spec_helper"
require "date"

describe "DateRange class" do
  describe "DateRange instantiation" do
    before do
      @date_range = Hotel::DateRange.new("03-04-2019", "06-04-2019")
    end

    it "is an instance of DateRange" do
      expect(@date_range).must_be_kind_of Hotel::DateRange
    end

    it "raises an ArgumentError for invalid end date" do
      expect {
        Hotel::DateRange.new("03-08-2019", "03-04-2019")
      }.must_raise ArgumentError
    end

    it "raises an ArgumentError for same-day bookings" do
      expect {
        Hotel::DateRange.new("03-08-2019", "03-08-2019")
      }.must_raise ArgumentError
    end

    it "start and end dates are Date instances" do
      expect(@date_range.start_date).must_be_instance_of Date
      expect(@date_range.end_date).must_be_instance_of Date
    end
  end
  describe "date range methods" do
    before do
      @date_range = Hotel::DateRange.new("03-04-2019", "06-04-2019")
      @start_date = Date.parse("03-04-2019")
      @end_date = Date.parse("06-04-2019")
    end

    it "returns the correct date range" do
      expect(@date_range.range).must_equal (@start_date...@end_date)
    end

    it "calculates the duration in date range" do
      expect(@date_range.duration).must_equal 3
    end

    it "detects an overlapping date" do
      date = Date.parse("05-04-2019")
      expect(@date_range.overlap?(date)).must_equal true
    end

    it "detects an available date" do
      date = Date.parse("11-04-2019")
      expect(@date_range.overlap?(date)).must_equal false
    end
  end
end
