require 'date'
require_relative 'spec_helper'

describe Hotel::Date_Range do
  describe 'consructor' do
    it 'Can be initialized with two dates' do
      checkin_date = Date.new(2017, 01, 01)
      checkout_date = checkin_date + 3

      range = Hotel::Date_Range.new(checkin_date, checkout_date)

      range.checkin_date.must_equal checkin_date
      range.checkout_date.must_equal checkout_date
    end

    it "is an an error for negative-lenght ranges" do
      checkin_date = Date.new(2017, 01, 01)
      checkout_date = checkin_date - 3

      proc {
        Hotel::Date_Range.new(checkin_date, checkout_date)
      }.must_raise ArgumentError
    end

    it "is an error to create a 0-length range" do
      checkin_date = Date.new(2017, 01, 01)
      checkout_date = checkin_date

      proc {
        Hotel::Date_Range.new(checkin_date, checkout_date)
      }.must_raise ArgumentError
    end
  end

  describe 'overlaps' do
    before do
      checkin_date = Date.new(2017, 01, 01)
      checkout_date = checkin_date + 3

      @range = Hotel::Date_Range.new(checkin_date, checkout_date)
    end

    it "returns true for the same range" do
      checkin_date = @range.checkin_date
      checkout_date = @range.checkout_date
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal true
    end

    it "returns true for a contained range" do
      checkin_date = @range.checkin_date + 1
      checkout_date = @range.checkout_date - 1
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal true
    end

    it "returns true for a range that overlaps in front" do
      checkin_date = @range.checkin_date - 1
      checkout_date = @range.checkout_date - 1
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      checkin_date = @range.checkin_date + 1
      checkout_date = @range.checkout_date + 1
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal true
    end

    it "returns true for a containing range" do
      checkin_date = @range.checkin_date - 1
      checkout_date = @range.checkout_date + 1
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal true
    end

    it "returns false for a range starting on the checkout_date date" do
      checkin_date = @range.checkout_date
      checkout_date = @range.checkout_date + 3
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal false
    end

    it "returns false for a range ending on the checkin date" do
      checkin_date = @range.checkin_date - 3
      checkout_date = @range.checkin_date
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal false
    end

    it "returns false for a range completely before" do
      checkin_date = @range.checkin_date - 10
      checkout_date = @range.checkout_date - 10
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal false
    end

    it "returns false for a date completely after" do
      checkin_date = @range.checkin_date + 10
      checkout_date = @range.checkout_date + 10
      test_range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.overlaps(test_range).must_equal false
    end
  end

  describe 'contains' do
    before do
      checkin_date = Date.new(2017, 01, 01)
      checkout_date = checkin_date + 3

      @range = Hotel::Date_Range.new(checkin_date, checkout_date)
    end

    it "returns false if the date is clearly out" do
      @range.contains(@range.checkin_date - 5).must_equal false
      @range.contains(@range.checkout_date + 5).must_equal false
    end

    it "returns true for dates in the range" do
      (@range.checkin_date...@range.checkout_date).each do |date|
        @range.contains(date).must_equal true
      end
    end

    it "returns false for the checkout_date date" do
      @range.contains(@range.checkout_date).must_equal false
    end
  end

  describe "nights" do
    it "returns the correct number of nights" do
      nights = 3
      checkin_date = Date.new(2017, 01, 01)
      checkout_date = checkin_date + nights

      @range = Hotel::Date_Range.new(checkin_date, checkout_date)

      @range.nights_stayed.must_equal nights
    end
  end
end
