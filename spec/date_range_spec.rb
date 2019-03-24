require "spec_helper"

describe "validate date method" do
  it "raises an ArgumentError if date is not a string" do
    expect { Hotel::DateRange.validate_date(2019 - 03 - 12) }.must_raise ArgumentError
  end

  it "raises an ArgumentError if the date is not the right format" do
    expect { Hotel::DateRange.validate_date("03/12/2019") }.must_raise ArgumentError
  end

  it "raises an ArgumentError if the date is nil" do
    expect { Hotel::DateRange.validate_date(nil) }.must_raise ArgumentError
  end

  it "raises an ArgumentError if month is larger than 12" do
    expect { Hotel::DateRange.validate_date("2019-13-12") }.must_raise ArgumentError
  end

  it "raises an ArgumentError if day is larger than 31" do
    expect { Hotel::DateRange.validate_date("2019-03-32") }.must_raise ArgumentError
  end
end

describe "validate date range method" do
  it "raises an Argument Error if the check_out_date is before the check_in_date" do
    expect { Hotel::DateRange.new.validate_date_range("2019-03-10", "2019-03-09") }.must_raise ArgumentError
  end
end
