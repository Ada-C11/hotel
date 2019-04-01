require_relative "spec_helper"
require_relative "../lib/date_range.rb"

describe "date range class" do
  before do
    @dates = HotelSystem::DateRange.new(start_year: 2019, start_month: 1, start_day: 1, num_nights: 3)
  end

  describe "initialization" do
    it "creates a new DateRange" do
      expect(@dates).must_be_kind_of HotelSystem::DateRange
    end

    it "doesn't accept invalid start_year input" do
      expect {
        HotelSystem::DateRange.new(start_year: 19, start_month: 1, start_day: 1)
      }.must_raise ArgumentError
    end

    it "doesn't accept invalid start_month input" do
      expect {
        HotelSystem::DateRange.new(start_year: 2019, start_month: 15, start_day: 1)
      }.must_raise ArgumentError
    end

    it "doesn't accept invalid start_day input" do
      expect {
        HotelSystem::DateRange.new(start_year: 2019, start_month: 1, start_day: 32)
      }.must_raise ArgumentError
    end

    it "doesn't accept invalid date input" do
      expect {
        HotelSystem::DateRange.new(start_year: 2019, start_month: 2, start_day: 30)
      }.must_raise ArgumentError
    end
  end

  describe "valid_date_entry method" do
    it "doesn't accept invalid start_year input" do
      expect {
        HotelSystem::DateRange.valid_date_entry?(year: 19, month: 1, day: 1)
      }.must_raise ArgumentError
    end

    it "doesn't accept invalid start_month input" do
      expect {
        HotelSystem::DateRange.valid_date_entry?(year: 2019, month: 15, day: 1)
      }.must_raise ArgumentError
    end

    it "doesn't accept invalid start_day input" do
      expect {
        HotelSystem::DateRange.valid_date_entry?(year: 2019, month: 1, day: 32)
      }.must_raise ArgumentError
    end

    it "doesn't accept invalid date input" do
      expect {
        HotelSystem::DateRange.valid_date_entry?(year: 2019, month: 2, day: 30)
      }.must_raise ArgumentError
    end
  end

  describe "date_list method" do
    it "returns an array" do
      expect(@dates.date_list).must_be_kind_of Array
    end

    it "returns a length of 1 if num_nights is nil" do
      dates = HotelSystem::DateRange.new(start_year: 2019, start_month: 1, start_day: 1)
      expect(dates.date_list.length).must_equal 1
    end

    it "length of returned array is equal to number of nights + 1" do
      #checkout day should be included in list but it would not be included in num_nights
      dates = HotelSystem::DateRange.new(start_year: 2019, start_month: 1, start_day: 1, num_nights: 5)
      expect(dates.date_list.length).must_equal 6
    end

    it "must be an array of date class objects" do
      expect(@dates.date_list.first).must_be_kind_of Date
      expect(@dates.date_list.last).must_be_kind_of Date
    end

    it "first date in array is start date" do
      jan_1_2019 = Date.new(2019, 1, 1)

      expect(@dates.date_list.first).must_equal jan_1_2019
    end

    it "last date in array is correct date" do
      dates = HotelSystem::DateRange.new(start_year: 2019, start_month: 1, start_day: 1, num_nights: 5)
      jan_6_2019 = Date.new(2019, 1, 6)

      expect(dates.date_list.last).must_equal jan_6_2019
    end
  end

  describe "include? method" do
    it "raises an ArgumentError if the input isn't a Date" do
      expect {
        @dates.include?("cat")
      }.must_raise ArgumentError
    end
  end

  describe "overlap? method" do
    it "will return true if there is an overlap in the date ranges" do
      dates2 = HotelSystem::DateRange.new(start_year: 2019, start_month: 1, start_day: 2, num_nights: 2)

      result = @dates.overlap?(dates2)
      expect(result).must_equal true
    end

    it "will return false if there is not an overlap" do
      dates2 = HotelSystem::DateRange.new(start_year: 2019, start_month: 5, start_day: 2, num_nights: 2)

      result = @dates.overlap?(dates2)
      expect(result).must_equal false
    end

    it "will return false if one reservation begins on the day of another reservation's checkout" do
      dates2 = HotelSystem::DateRange.new(start_year: 2019, start_month: 1, start_day: 4, num_nights: 2)

      result = @dates.overlap?(dates2)
      expect(result).must_equal false
    end
  end
end
