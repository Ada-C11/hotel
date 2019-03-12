require_relative "spec_helper"

describe "RoomManager" do
  let(:room_manager) {
    Hotel::RoomManager.new
  }
  describe "initialize" do
    it "can be instantiated" do
      expect(room_manager).must_be_kind_of Hotel::RoomManager
    end

    it "establishes the bast structures when instantiated" do
      [:rooms, :reservations].each do |prop|
        expect(room_manager).must_respond_to prop
      end

      expect(room_manager.rooms).must_be_kind_of Array
      expect(room_manager.reservations).must_be_kind_of Array
    end

    it "has 20 rooms" do
      expect(room_manager.rooms.length).must_equal 20
    end
  end

  describe "connects reservations with rooms" do
    it "accurately connects reservations with rooms" do
      room_manager.reservations.each do |reservation|
        expect(reservation.room).wont_be_nil
        expect(reservation.room.room_id).must_equal reservation.room_id
        expect(reservation.room.reservations).must_include room
      end
    end
  end
end
