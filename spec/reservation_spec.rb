require_relative "spec_helper"

describe "Reservation" do
  describe "initialize" do
    before do
      room = HotelSystem::Room.new(id: 1)
      arrive_day = Date.new(2019, 2, 10)
      depart_day = Date.new(2019, 2, 14)
      @reservation = HotelSystem::Reservation.new(room: room, arrive_day: arrive_day, depart_day: depart_day)
    end
    it "Creates a new instance of Reservation" do
      expect(@reservation).must_be_kind_of HotelSystem::Reservation
    end

    it "stores an instance of Room" do
      expect(@reservation.room).must_be_kind_of HotelSystem::Room
    end
  end
end
