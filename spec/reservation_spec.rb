require_relative 'spec_helper'

describe "Reservation class" do
  describe "Reservation instantiation" do
    before do
      @room = Hotel::Room.new(
        room_num: 15,
        cost_per_night: 200)
      @reservation = Hotel::Reservation.new(
        start_date: "2016-08-08",
        end_date: "2016-08-15",
        room: @room
      )
    end
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "calculates the total cost of the reservation correctly" do
      expect(@reservation.calculate_cost).must_equal 1400
    end

  end
end
