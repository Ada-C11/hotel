require "spec_helper"

describe "Room class" do
  before do
    def make_room(id: id, rate: rate, reservations: reservations)
      HotelSystem::Room.new(id: id, rate: rate, reservations: reservations)
    end
  end
  describe "initialize method" do
    before do
      @new_room = make_room(id: 1, rate: 200)
    end
    it "initializes a room object" do
      expect(@new_room).must_be_instance_of HotelSystem::Room
    end
  end
end
