require_relative "spec_helper"
require "Date"

describe "Reservation class" do
  describe "Reservation instantiation" do
    before do
      @room = Hotel::Room.new(
        id: 1,
      )
      @reservation = Hotel::Reservation.new(
        id: 1,
        start_date: Date.new(2001, 2, 3),
        end_date: Date.new(2001, 2, 5),
        room: @room,
      )
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "includes a room object as its room attribute" do
      expect(@reservation.room).must_be_kind_of Hotel::Room
    end

    it "has start date that is instance of Date" do
      @reservation.start_date.must_be_kind_of Date
    end

    it "has an end date that is instance of Date" do
      @reservation.end_date.must_be_kind_of Date
    end

    it "returns a reservation's total cost accurately" do
      expect(@reservation.total_cost).must_equal @room.cost * (@reservation.end_date - @reservation.start_date).to_i
    end

    it "raises an error for an invalid date range" do
      @room = Hotel::Room.new(
        id: 2,
      )

      expect {
        @reservation = Hotel::Reservation.new(
          id: 2,
          start_date: Date.new(2001, 2, 7),
          end_date: Date.new(2001, 2, 5),
          room: @room,
        )
      }.must_raise ArgumentError
    end
  end
end
