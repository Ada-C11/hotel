require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Reservation class" do
  describe "initialize" do
    before do
      @nights = [Date.new(2021, 10, 8), Date.new(2021, 10, 9), Date.new(2021, 10, 10), Date.new(2021, 10, 11)]
      input = { name: "Butter",
               room_id: 5,
               check_in_date: Date.new(2021, 10, 8),
               check_out_date: Date.new(2021, 10, 12) }
      @reservation = Hotel::Reservation.new(input)
    end

    it "creates an instance of a Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "has a check-in date" do
      expect(@reservation.check_in_date).must_be_kind_of Date
    end

    it "has a check-out date" do
      expect(@reservation.check_out_date).must_be_kind_of Date
    end

    it "has has a room id" do
      expect(@reservation.room_id).must_equal 5
    end
  end
end
