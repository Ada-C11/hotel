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
end
