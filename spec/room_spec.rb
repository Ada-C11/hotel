require_relative "spec_helper"

describe "Room class" do
  describe "initialize method" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
    end
    it "initializes a room object" do
      expect(@new_room).must_be_instance_of HotelSystem::Room
    end
  end
  describe "reader methods" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
    end
    it "can retrieve room id" do
      expect(@new_room.id).must_equal 1
    end
    it "can retrieve room rate" do
      expect(@new_room.rate).must_equal 200
    end
    it "can retrieve room reservations" do
      expect(@new_room.reservations).must_be_instance_of Array
      expect(@new_room.reservations).must_be_empty
    end
  end
  describe "add reservation" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
      @new_res = HotelSystem::Reservation.new(start_date: "01 Feb 2020", end_date: "08 Feb 2020", room: @new_room, id: 1)
    end
    it "can add a reservation to the room" do
      before = @new_room.reservations.length
      @new_room.add_reservation(@new_res)
      after = @new_room.reservations.length

      expect(after).must_equal before + 1
      expect(@new_room.reservations.last).must_equal @new_res
    end
  end
end
