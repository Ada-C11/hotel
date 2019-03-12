require_relative "spec_helper"

describe "Reservation" do
  before do
    @reservation = BookingSystem::Reservation.new(room: BookingSystem::Room.new(room_num: 1),
                                                  checkin_date: Date.new(2019, 1, 1),
                                                  checkout_date: Date.new(2019, 1, 3))
  end

  describe "#initialize" do
    it "creates an instance of Reservation " do
      expect(@reservation).must_be_kind_of BookingSystem::Reservation
    end

    it "initializes Reservation with an instance of Room" do
      expect(@reservation.room).must_be_kind_of BookingSystem::Room
    end

    it "raises ArgumentError when given invalid dates" do
      # expect(not_a_Date).must_raise ArgumentError
      # expect(checkout>checkin).must_raise ArgumentError
    end
  end

  xdescribe "#total_cost" do
    it "calculates total cost of a reservation" do
      expect(@cost).must_equal 400
    end
  end
end