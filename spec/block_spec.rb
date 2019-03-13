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
    new_reservation = @hotel.reserve_room(333, Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)
    new_reservation2 = @hotel.reserve_room(334, Date.new(2001, 3, 5), Date.new(2001, 3, 7), 1)
    new_reservation3 = @hotel.reserve_room(335, Date.new(2001, 3, 9), Date.new(2001, 3, 15), 2)
    new_reservation4 = @hotel.reserve_room(336, Date.new(2001, 3, 4), Date.new(2001, 3, 12), 12)

    @hotel.add_reservation(new_reservation)
    @hotel.add_reservation(new_reservation2)
    @hotel.add_reservation(new_reservation3)
    @hotel.add_reservation(new_reservation4)

    new_reservation.room.add_reservation(new_reservation)
    new_reservation2.room.add_reservation(new_reservation2)
    new_reservation3.room.add_reservation(new_reservation3)
    new_reservation4.room.add_reservation(new_reservation4)

    start_date = Date.new(2001, 2, 5)
    end_date = Date.new(2001, 2, 10)
    @collection_rooms = []
    5.times { |k| @collection_rooms << Hotel::Room.new(id: k + 1) }
    @discounted_rate = 150
    @hotel_block_reserved = @hotel.reserve_hotel_block(1, start_date, end_date, @collection_rooms, @discounted_rate)
  end
  describe "Block instantiation" do
    it "creates an instance of type Block" do
      expect(@hotel_block_reserved).must_be_kind_of Hotel::Block
    end

    it "raises an argument error if tries to create Hotel Block and one of the rooms is unavailable for the given data range" do
      start_date = Date.new(2001, 3, 5)
      end_date = Date.new(2001, 3, 10)
      expect { @hotel.reserve_hotel_block(1, start_date, end_date, @collection_rooms, @discounted_rate) }.must_raise ArgumentError
    end
  end

  describe "#add_hotel_block" do
    it "adds block to hotel instance variable @hotel_block" do
      @hotel.add_hotel_block(@hotel_block_reserved)
      expect(@hotel.hotel_blocks.length).must_equal 1
    end
  end
end
