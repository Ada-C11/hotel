require_relative 'spec_helper'

describe "HotelDispatcher class" do
  describe "HotelDispatcher instantiation" do
    before do
      @room = Hotel::Room.new(
        room_num: 15
      )
    end

    it "is an instance of Reservation" do
      expect(Hotel::HotelDispatcher.new).must_be_kind_of Hotel::HotelDispatcher
    end
    it "returns array of all the rooms" do
      expect(Hotel::HotelDispatcher.list_all_rooms.length).must_equal 20
    end
    it "reserves a room" do
      new_booking = Hotel::HotelDispatcher.new
      expect(new_booking.reserve("2019-2-23", "2019-2-25")).must_be_kind_of Hotel::Reservation
    end


  end
end