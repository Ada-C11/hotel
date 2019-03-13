require_relative "spec_helper"

describe "Reservation" do
  before do
    @test_room = BookingSystem::Room.new(room_num: 1)
    @checkin = Date.new(2019, 1, 1)
    @checkout = Date.new(2019, 1, 11)
    @reservation = BookingSystem::Reservation.new(room: @test_room,
                                                  checkin_date: @checkin,
                                                  checkout_date: @checkout)
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
        BookingSystem::Reservation.new(room: @test_room,
                                        checkin_date: @checkin,
                                        checkout_date: 1234)
      end.must_raise ArgumentError
      expect do
        BookingSystem::Reservation.new(room: @test_room,
                                        checkin_date: 1234,
                                        checkout_date: @checkout)
      end.must_raise ArgumentError
    end 

    it "raises ArgumentError when check-out date is later than check-in date" do
      expect do
        BookingSystem::Reservation.new(room: @test_room,
                                        checkin_date: @checkin,
                                        checkout_date: @checkin - 100)
      end.must_raise ArgumentError
    end
  end

  describe "#total_cost" do
    it "calculates total cost of a reservation" do
      expect(@reservation.total_cost).must_equal ((@checkout - @checkin) * STANDARD_RATE)
    end
  end
end