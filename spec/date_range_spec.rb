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

    it "detects an overlapping date range" do
      before_range = "02-04-2019"
      start_date = "03-04-2019"
      during_range1 = "04-04-2019"
      during_range2 = "05-04-2019"
      end_date = "06-04-2019"
      after_range = "07-04-2019"

      range1 = Hotel::DateRange.new(before_range, during_range1)
      range2 = Hotel::DateRange.new(before_range, end_date)
      range3 = Hotel::DateRange.new(before_range, after_range)
      range4 = Hotel::DateRange.new(start_date, during_range1)
      range4 = Hotel::DateRange.new(start_date, end_date)
      range5 = range4 = Hotel::DateRange.new(start_date, after_range)
      range6 = Hotel::DateRange.new(during_range1, during_range2)
      range7 = Hotel::DateRange.new(during_range1, end_date)
      range8 = Hotel::DateRange.new(during_range1, after_range)

      ranges = [range1, range2, range3, range4, range5, range6, range7, range8]

      ranges.each do |range|
        expect(@date_range.overlap?(range)).must_equal true
      end
    end

    it "detects an available date" do
      before_range1 = "01-04-2019"
      before_range2 = "02-04-2019"
      start_date = "03-04-2019"
      end_date = "06-04-2019"
      after_range1 = "07-04-2019"
      after_range2 = "08-04-2019"

      range9 = Hotel::DateRange.new(before_range1, before_range2)
      range10 = Hotel::DateRange.new(before_range2, start_date)
      range11 = Hotel::DateRange.new(end_date, after_range1)
      range12 = Hotel::DateRange.new(after_range1, after_range2)

      ranges = [range9, range10, range11, range12]
      ranges.each do |range|
        expect(@date_range.overlap?(range)).must_equal false
      end
    end
  end
end
