require_relative "spec_helper"

describe "DateRange" do
  let(:dates) {
    DateRange.new(check_in: "March 21, 2022", check_out: "March 23rd, 2022")
  }
  let(:bogus) {
    "March 88th, 2020"
  }
  let(:past) {
    "March 1st, 2019"
  }

  it "is an instance of DateRange" do
    expect(dates).must_be_kind_of DateRange
  end

  it "raises exception for blank dates" do
    expect {
      DateRange.new(check_in: "", check_out: "")
    }.must_raise ArgumentError

    expect {
      DateRange.new(check_in: "", check_out: "July 3rd 2019")
    }.must_raise ArgumentError

    expect {
      DateRange.new(check_in: "July 3rd 2019", check_out: "")
    }.must_raise ArgumentError
  end

  it "creates date objects from strings" do
    expect(dates.check_in).must_be_kind_of Date
    expect(dates.check_out).must_be_kind_of Date
  end

  it "must accurately record check-in date" do
    expect(dates.check_in).must_equal Date.parse("2022-03-21")
    expect(dates.check_out).must_equal Date.parse("2022-03-23")
  end

  it "can validate that a check-in date occurs before check-out" do
    expect {
      DateRange.new(check_in: "September 15th 2023", check_out: "September 8th 2023")
    }.must_raise ArgumentError
  end

  it "raises an exception for an invalid check-in day" do
    expect {
      dates.valid_date?(bogus)
    }.must_raise ArgumentError
  end

  it "raises an exception for past dates" do
    expect {
      dates.valid_date?(past)
    }.must_raise ArgumentError
  end
end
