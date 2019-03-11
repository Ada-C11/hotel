require_relative "spec_helper"

describe "Hotel" do
  describe "initialize" do
    before do
      @hotel = HotelSystem::Hotel.new(id: 1)
    end
    it "Creates an instance of a Hotel" do
      expect(@hotel).must_be_kind_of HotelSystem::Hotel
    end

    it "Creates a hotel with default parameters" do
      expect(@hotel.reservations).must_equal []
      expect(@hotel.rooms).must_equal []
      expect(@hotel.blocks).must_equal []
    end
  end
end
