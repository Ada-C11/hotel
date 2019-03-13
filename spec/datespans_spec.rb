require_relative "spec_helper"

describe "initialize" do
  before do
    @dates = Hotel::DateSpan.new("2019-07-19", "2019-07-21")
  end

  it "is an instance of datespan" do
    expect(@dates).must_be_kind_of Hotel::DateSpan
  end

  it "takes check_in, check_out args" do
    expect(@dates).must_respond_to :check_in
    expect(@dates).must_respond_to :check_out
  end

  it "raises an ArgumentError if check-out is before check-in" do
    expect { Hotel::DateSpan.new("07-19", "07-16") }.must_raise ArgumentError
  end

  it "makes sure dates are instances of Date" do
    expect(@dates.check_in).must_be_kind_of Date
    expect(@dates.check_out).must_be_kind_of Date
  end
end

describe "tests the overlaps? method" do
  before do
    @dates = Hotel::DateSpan.new("2019-07-19", "2019-07-21")
    @dates2 = Hotel::DateSpan.new("2019-07-22", "2019-07-24")
  end

  it "finds if date ranges overlap" do
    overlaps = @dates2.overlaps?(@dates)
    expect(overlaps).must_equal false
  end
end
