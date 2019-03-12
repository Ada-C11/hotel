require_relative "spec_helper"

describe "Reservation" do
  before do
    @reservation = BookingSystem::Reservation.new(room: BookingSystem::Room.new(room_num: 1),
                                                  checkin_date: Date.new(2019, 1, 1),
                                                  checkout_date: Date.new(2019, 1, 11))
  end

  describe "#initialize" do
    it "creates an instance of Reservation " do
      expect(@reservation).must_be_kind_of BookingSystem::Reservation
    end

    it "initializes Reservation with an instance of Room" do
      expect(@reservation.room).must_be_kind_of BookingSystem::Room
    end

    it "raises ArgumentError when date supplied is not an instance of Date" do
      expect do
        BookingSystem::Reservation.new(room: BookingSystem::Room.new(room_num: 1),
                                                  checkin_date: (2019-1-1),
                                                  checkout_date: (2018-1-1))
      end.must_raise ArgumentError
    end 

    it "raises ArgumentError when check-out date is later than check-in date" do
      expect do
        BookingSystem::Reservation.new(room: BookingSystem::Room.new(room_num: 1),
        checkin_date: Date.new(2019, 1, 1),
        checkout_date: Date.new(2018, 1, 1))
      end.must_raise ArgumentError
    end
  end

  describe "#total_cost" do
    it "calculates total cost of a reservation" do
      expect(@reservation.total_cost).must_equal 2000
    end
  end
end