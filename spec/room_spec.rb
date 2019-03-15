require_relative "spec_helper"

describe "Room Class" do
  describe "Initialize" do
    let (:room) { Hotel::Room.new(number: 3) }

    it "Is an instance of Room" do
      expect(room).must_be_kind_of Hotel::Room
    end

    it "Stores a room number" do
      expect(room.number).must_equal 3
    end

    # might want to move this test into ReservationManager#request_reservation
    it "Stores an instance of a reservation" do
      manager = Hotel::ReservationManager.new
      reservation = manager.request_reservation("feb5", "feb7")
      expect(manager.rooms.first.reservations.length).must_equal 1
      expect(manager.rooms.first.reservations.first).must_be_kind_of Hotel::Reservation
    end
  end
end
