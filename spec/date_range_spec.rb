require_relative "spec_helper"

describe "DateRange class" do
  before do
    def make_date_range(start_date:, end_date:)
      return HotelSystem::DateRange.new(start_date, end_date)
    end
  end
  describe "initialize method" do
    before do
      @start_date = "01 Feb 2020"
      @end_date = "08 Feb 2020"
      @new_range = make_date_range(start_date: @start_date, end_date: @end_date)
    end
    it "creates an object of type DateRange" do
      expect(@new_range).must_be_instance_of HotelSystem::DateRange
    end
    it "correctly parses strings into start and end dates" do
      expected_start = Date.parse (@start_date)
      expected_end = Date.parse (@end_date)

      expect(@new_range.start_date).must_be_instance_of Date
      expect(@new_range.start_date).must_equal expected_start

      expect(@new_range.end_date).must_be_instance_of Date
      expect(@new_range.end_date).must_equal expected_end
    end
    it "creates an array of dates within the range" do
      expect(@new_range.dates).must_be_instance_of Array

      expected_start = Date.parse(@start_date)
      expected_end = Date.parse(@end_date)
      range = (expected_start...expected_end)

      @new_range.dates.each do |date|
        expect(date).must_be_instance_of Date
        expect(range).must_include date
      end
    end
    it "excludes the last day in its dates array" do
      expect(@new_range.dates).wont_include @new_range.end_date
    end
    it "raises an exception if end date is before or the same as start date" do
      expect { make_date_range(start_date: "01 Feb 2020", end_date: "01 Jan 2019") }.must_raise DateRangeError
    end
  end
  describe "includes date" do
    it "checks if it includes a date" do
      date_range = make_date_range(start_date: "01 Feb 2020", end_date: "08 Feb 2020")
      test_date_1 = Date.parse("04 Feb 2020")
      test_date_2 = Date.parse("04 Mar 2020")

      expect(date_range.includes_date?(test_date_1)).must_equal true
      expect(date_range.includes_date?(test_date_2)).must_equal false
    end
  end
  describe "overlap method" do
    it "checks if its dates overlap with the dates of another DateRange" do
      date_range = make_date_range(start_date: "01 Feb 2020", end_date: "08 Feb 2020")
      date_with_overlap = make_date_range(start_date: "04 Feb 2020", end_date: "14 Feb 2020")
      date_with_no_overlap = make_date_range(start_date: "04 Mar 2020", end_date: "14 Mar 2020")

      test_1 = date_range.overlap?(date_with_overlap)
      test_2 = date_range.overlap?(date_with_no_overlap)

      expect(test_1).must_equal true
      expect(test_2).must_equal false
    end
  end
end
