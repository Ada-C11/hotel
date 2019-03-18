require_relative "spec_helper"
require "date"

describe "Block class" do
  describe "initialize" do
    before do
      @hotel = HotelSystem::Hotel.new
    end

    let (:block) {
      HotelSystem::Block.new(start_date: Date.new(2019, 3, 11),
                             end_date: Date.new(2019, 3, 14),
                             room_collection: [@hotel.all_rooms[0], @hotel.all_rooms[1], @hotel.all_rooms[2]])
    }

    it "is an instance of a block" do
      expect(block).must_be_kind_of HotelSystem::Block
    end

    it "establishes the base data structures when instantiated" do
      expect(block.room_collection).must_be_kind_of Array
      expect(block.reservations).must_be_kind_of Array
    end

    it "raises an error if less than 2 rooms are included in the collection of rooms" do
      expect do
        HotelSystem::Block.new(start_date: Date.new(2019, 3, 11),
                               end_date: Date.new(2019, 3, 14),
                               room_collection: [@hotel.all_rooms[0]])
      end.must_raise ArgumentError
    end

    it "raises an error if more than 5 rooms are included in the collection of rooms" do
      expect do
        HotelSystem::Block.new(start_date: Date.new(2019, 3, 11),
                               end_date: Date.new(2019, 3, 14),
                               room_collection: [@hotel.all_rooms[0], @hotel.all_rooms[1], @hotel.all_rooms[2], @hotel.all_rooms[3], @hotel.all_rooms[4], @hotel.all_rooms[5]])
      end.must_raise ArgumentError
    end
  end

  describe "room_collection_blockable? method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @room = @hotel.all_rooms[0]

      3.times do
        @hotel.reserve_room(@room,
                            Date.new(2019, 3, 12),
                            Date.new(2019, 3, 14),
                            "Sam")
      end
    end

    it "throwns an error if the rooms in the room collection are not available during the specified block dates" do
      expect do
        @block = HotelSystem::Block.new(start_date: Date.new(2019, 3, 12),
                                      end_date: Date.new(2019, 3, 14),
                                      room_collection: [@hotel.all_rooms[2], @hotel.all_rooms[3], @hotel.all_rooms[4]])
      end.must_raise ArgumentError
    end
  end

  describe "room_still_available? method" do
    before do
      @hotel = HotelSystem::Hotel.new
    end

    let (:block) {
      HotelSystem::Block.new(start_date: Date.new(2019, 3, 11),
                             end_date: Date.new(2019, 3, 14),
                             room_collection: [@hotel.all_rooms[0], @hotel.all_rooms[1], @hotel.all_rooms[2]])
    }

    it "returns true if there is a room available for reservation in the block" do
      expect(block.room_still_available?).must_equal true
    end

    it "returns false if there is not a room available for reservation in the block" do
      res1 = HotelSystem::Reservation.new(room: @hotel.all_rooms[0],
                                          start_date: Date.new(2019, 3, 11),
                                          end_date: Date.new(2019, 3, 14),
                                          guest: "Sam")
      block.reservations << res1

      res2 = HotelSystem::Reservation.new(room: @hotel.all_rooms[1],
                                          start_date: Date.new(2019, 3, 11),
                                          end_date: Date.new(2019, 3, 14),
                                          guest: "Sam")
      block.reservations << res2

      res3 = HotelSystem::Reservation.new(room: @hotel.all_rooms[2],
                                          start_date: Date.new(2019, 3, 11),
                                          end_date: Date.new(2019, 3, 14),
                                          guest: "Sam")
      block.reservations << res3

      expect(block.room_still_available?).must_equal false
    end
  end
end
