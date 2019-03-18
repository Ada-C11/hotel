require_relative 'spec_helper'
require 'pry'

describe "Reservation class" do
  before do
    @test_reservation = Hotel::Reservation.new("2019/05/05", "2019/05/12", 5)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@test_reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "validation and error messages" do
    it "throws argument error at bad check_in date" do
      expect { Hotel::Reservation.new(nil, "2019/07/21", 3) }.must_raise
      Errors::ValidationError
    end

    it "throws argument error at bad check_out date" do
      expect { Hotel::Reservation.new("2019/07/20", nil, 3) }.must_raise
      Errors::ValidationError
    end

    it "throws an argument error at other wonky dates" do
      expect { Hotel::Reservation.new("2019/07/20", "2019/07/20", 5) }.must_raise
      Errors::NotThatKindofHotelPal
      expect { Hotel::Reservation.new("2015-07-21", "2015-07-20", 5) }.must_raise
      Errors::ReverseDates
    end
  end

  describe "duration method" do
    it "returns duration of stay correctly calculated and as an integer" do
      expect @test_reservation.duration.must_equal(7)
    end
  end

  describe "range method" do
    it "returns a range of Date objects" do
      expect @test_reservation.range.must_be_kind_of Range
      expect @test_reservation.range.first.must_be_kind_of Date
    end
  end

  describe "total method" do
    it "returns the correct total for reservations as a float" do
      expect @test_reservation.total.must_equal(1400.00)
    end
  end
end
