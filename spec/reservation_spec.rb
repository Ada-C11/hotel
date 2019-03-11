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
  end
end
