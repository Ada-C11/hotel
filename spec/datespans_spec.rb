require_relative "spec_helper"
# TODO: EVERYTHING OH THE HUMANITY FIX IT FIX IT FIX IT KAAAAATE WHAT HAVE YOU DONE!?
# TODO: DISASTERS!
# TODO: THE HOTEL IS ON FIRE?
describe "initialize" do
  before do
    @dates = Hotel::DateRange.new("2019-07-19", "2019-07-21")
  end

  it "is an instance of DateRange" do
    expect(@dates).must_be_kind_of Hotel::DateRange
  end

  it "takes check_in, check_out args" do
    expect(@dates).must_respond_to :check_in
    expect(@dates).must_respond_to :check_out
  end

  it "raises an ArgumentError if check-out is before check-in" do
    expect { Hotel::DateRange.new("07-19", "07-16") }.must_raise ArgumentError
  end

  it "makes sure dates are instances of Date" do
    expect(@dates.check_in).must_be_kind_of Date
    expect(@dates.check_out).must_be_kind_of Date
  end
end

describe "tests the overlaps? method" do
  before do
    @dates = Hotel::DateRange.new("2019-07-19", "2019-07-21")
    @dates2 = Hotel::DateRange.new("2019-07-22", "2019-07-24")
  end

  it "finds if date ranges overlap" do
    overlaps = @dates2.overlaps?(@dates)
    expect(overlaps).must_equal false
  end
end
