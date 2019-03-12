require_relative "spec_helper"

describe "Hotel class" do
  before do
    @new_hotel = HotelSystem::Hotel.new
  end
  describe "initialize" do
    it "initializes a Hotel object" do
      expect(@new_hotel).must_be_instance_of HotelSystem::Hotel
    end
    it "creates an array of Room objects" do
      expect(@new_hotel.rooms).must_be_instance_of Array
      @new_hotel.rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
    end
    it "creates an empty array of reservation objects" do
      expect(@new_hotel.reservations).must_be_instance_of Array
      expect(@new_hotel.reservations).must_be_empty
    end
  end
  describe "make reservation" do
    before do
      @new_hotel = HotelSystem::Hotel.new
      @new_res = @new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020")
      @test_room = @new_hotel.rooms.first
    end
    it "returns a new reservation if the room is available during the given dates" do
      expect(@new_res).must_be_instance_of HotelSystem::Reservation
    end

    it "adds the new reservation to the room's list of reservations" do
      expect(@test_room.reservations).must_include @new_res
    end

    it "returns nil if the room is not available during the given dates" do
      expect(@new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020")).must_be_nil
    end

    it "raises an ArgumentError if the dates given are invalid" do
      expect {
        @new_hotel.make_reservation(1, "08 Feb 2020", "01 Feb 2020")
      }.must_raise ArgumentError
    end
  end
end
