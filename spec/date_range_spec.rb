require "spec_helper"
require "date"

describe "DateRange class" do
  before do
    @date_range = Hotel::DateRange.new("03-04-2019", "03-08-2019")
  end

  it "is an instance of DateRange" do
    expect(@date_range).must_be_kind_of Hotel::DateRange
  end

  it "raises an ArgumentError for invalid end date" do
    expect {
      Hotel::DateRange.new("03-08-2019", "03-04-2019")
    }.must_raise ArgumentError
  end

  it "start and end dates are Date instances" do
    expect(@date_range.start_date).must_be_instance_of Date
    expect(@date_range.end_date).must_be_instance_of Date
  end

  it "detects an overlapping date" do
    date = Date.parse("03-05-2019")
    expect(@date_range.overlap?(date)).must_equal true
  end
end
