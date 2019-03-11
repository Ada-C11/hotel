require_relative "spec_helper"

describe "Hotel class" do
  describe "Hotel instantiation" do
    before do
      @rooms = []
      20.times do |k|
        @rooms << Hotel::Room.new(id: k)
      end
      @hotel = Hotel::Hotel.new(
        id: 1,
        rooms: @rooms,
        reservations: [],
      )
    end

    it "is an instance of Hotel" do
      expect(@hotel).must_be_kind_of Hotel::Hotel
    end

    it "returns an array of length 20 rooms in rooms attribute" do
      expect(@hotel.rooms.length).must_equal 20
    end

    it "returns an empty array of reservations when hotel first initialized" do
      expect(@hotel.reservations.length).must_equal 0
    end
  end

  describe "Reserve room method" do
  end
end
