require_relative "spec_helper"
require "Date"

describe "Block class" do
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
    @collection_rooms = [@rooms[0], @rooms[1], @rooms[2], @rooms[3], @rooms[4]]

    new_reservation = @hotel.reserve_room(Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)

    start_date = Date.new(2001, 2, 5)
    end_date = Date.new(2001, 2, 10)
    @discounted_rate = 150
    @hotel_block_reserved = @hotel.reserve_hotel_block(1, start_date, end_date, @collection_rooms, @discounted_rate)
  end
  describe "Block instantiation" do
    it "creates an instance of type Block" do
      expect(@hotel_block_reserved).must_be_kind_of Hotel::Block
    end
  end
end
