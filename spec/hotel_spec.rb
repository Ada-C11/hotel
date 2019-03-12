require_relative "spec_helper"

describe "Hotel class" do
  describe "initialize" do
    before do
      @hotel = HotelSystem::Hotel.new
    end

    it "is an instance of a Hotel" do
      expect(@hotel).must_be_kind_of HotelSystem::Hotel
    end

    it "establishes the base data structures when instantiated" do
      expect(@hotel.all_rooms).must_be_kind_of Array
      expect(@hotel.all_reservations).must_be_kind_of Array
    end

    it "lists all the possible rooms" do
      expect(@hotel.all_rooms.length).must_equal 20
    end
  end
end
