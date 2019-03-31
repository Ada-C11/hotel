require_relative "spec_helper"

describe "DateRange" do
  describe "initialize" do 
    it "is an instance of DateRange" do
      check_in = Date.new(2019, 04, 01)
      check_out = check_in + 3
      dates = DateRange.new(check_in, check_out)

      expect(dates).must_be_kind_of DateRange
      expect(dates.check_in).must_equal check_in
      expect(dates.check_out).must_equal check_out
    end

    it "raises exception for invalid date order" do
      check_in = Date.new(2019, 04, 01)
      check_out = check_in - 3
      expect{
        DateRange.new(check_in, check_out).must_raise DateRange::InvalidDateError
      }
    end

    it "raises an exception for 0 length date range" do
      check_in = Date.new(2019, 04, 01)
      check_out = check_in

      expect {
        DateRange.new(check_in, check_out)
      }.must_raise DateRange::InvalidDateError
    end
  end

  describe "overlaps" do 
    before do 
      check_in = Date.new(2019, 04, 01)
      check_out = check_in + 5
      @dates = DateRange.new(check_in, check_out)
    end

    it "returns false for dates that do not overlap" do 
      check_in = Date.new(2019, 03, 25)
      check_out = check_in + 2
      test_range = DateRange.new(check_in, check_out)

      expect(@dates.overlaps(test_range)).must_equal false
    end

    it "returns false for a date range starting on the same day another ends" do 
      check_in = @dates.check_out
      check_out = check_in + 2
      test_range = DateRange.new(check_in, check_out)

      expect(@dates.overlaps(test_range)).must_equal false
    end

    it "returns false for a date range ending on the same day another starts" do
      check_in = @dates.check_in - 4
      check_out = check_in + 2
      test_range = DateRange.new(check_in, check_out)

      expect(@dates.overlaps(test_range)).must_equal false
    end

    it "returns true for dates that overlap exactly" do 
      check_in = @dates.check_in
      check_out = @dates.check_out
      test_range = DateRange.new(check_in, check_out)

      expect(@dates.overlaps(test_range)).must_equal true
    end

    it "returns true for a reservation contained inside another" do 
      check_in = @dates.check_in + 1
      check_out = check_in + 2
      test_range = DateRange.new(check_in, check_out)

      expect(@dates.overlaps(test_range)).must_equal true
    end

    it "returns true for a range that starts before and ends during another range" do 
      check_in = @dates.check_in - 3
      check_out = @dates.check_out - 2
      test_range = DateRange.new(check_in, check_out)

      expect(@dates.overlaps(test_range)).must_equal true
    end

    it "returns true for a range that starts during and ends after another range" do 
      check_in = @dates.check_in + 2
      check_out = @dates.check_out + 2
      test_range = DateRange.new(check_in, check_out)

      expect(@dates.overlaps(test_range)).must_equal true
    end
  end

  describe "contains" do 
    before do 
      check_in = Date.new(2019, 10, 01)
      check_out = check_in + 5

      @dates = DateRange.new(check_in, check_out)
    end
    let(:within) { Date.new(2019, 10, 03) }
    let(:outside) { Date.new(2019, 10, 10) }
    let(:last_day) { Date.new(2019, 10, 06) }

    it "returns false when the date isn't within the range" do 
      @dates.contains(outside).must_equal false
    end

    it " returns true for a date contained within another range" do 
      @dates.contains(within).must_equal true
    end

    it "returns false for a check out date" do 
      @dates.contains(last_day).must_equal false
    end
  end
end
