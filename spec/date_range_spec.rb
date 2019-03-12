require_relative "spec_helper"
require_relative "../lib/date_range.rb"

describe "date_list method" do
    before do 
        @dates = HotelSystem::DateRange.new(start_year: 19, start_month: 1, start_day: 1)
    end

  it "returns an array" do
    expect(@dates.date_list).must_be_kind_of Array
  end

  it "returns a length of 1 if num_nights is nil" do
    expect(@dates.date_list.length).must_equal 1
  end

  it "length of returned array is equal to number of nights + 1" do
    #checkout day should be included in list but it would not be included in num_nights
    dates = HotelSystem::DateRange.new(start_year: 19, start_month: 1, start_day: 1, num_nights: 5)
    expect(dates.date_list.length).must_equal 6
  end

  it "must be an array of date class objects" do
    expect(@dates.date_list.first).must_be_kind_of Date
    expect(@dates.date_list.last).must_be_kind_of Date
  end

  it "first date in array is start date" do
    jan_1_2019 = Date.new(19, 1, 1)

    expect(@dates.date_list.first).must_equal jan_1_2019
  end

  it "last date in array is correct date" do
    dates = HotelSystem::DateRange.new(start_year: 19, start_month: 1, start_day: 1, num_nights: 5)
    jan_6_2019 = Date.new(19, 1, 6)

    expect(dates.date_list.last).must_equal jan_6_2019
  end
end
