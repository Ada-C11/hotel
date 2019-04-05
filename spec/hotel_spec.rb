require_relative "spec_helper"
require "date"
require "pry"

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

    it "contains all the possible rooms" do
      expect(@hotel.all_rooms.length).must_equal 20
      expect(@hotel.all_rooms[0]).must_be_kind_of HotelSystem::Room
      expect(@hotel.all_rooms[19]).must_be_kind_of HotelSystem::Room
    end
  end

  describe "see_reservations_by_date method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @room = @hotel.all_rooms[0]
      5.times do
        @hotel.reserve_room(
          @room,
          Date.new(2019, 3, 11),
          Date.new(2019, 3, 14),
          "Sam"
        )
      end

      3.times do
        @hotel.reserve_room(
          @room,
          Date.new(2019, 3, 12),
          Date.new(2019, 3, 14),
          "Sam"
        )
      end
    end

    it "returns only the reservations with the specified start date" do
      expect(@hotel.see_reservations_by_date(Date.new(2019, 3, 11))).must_be_kind_of Array
      expect(@hotel.see_reservations_by_date(Date.new(2019, 3, 11)).length).must_equal 5
      expect(@hotel.see_reservations_by_date(Date.new(2019, 3, 12)).length).must_equal 3
      expect(@hotel.see_reservations_by_date(Date.new(2019, 3, 13)).length).must_equal 0
    end
  end

  describe "see_available_rooms_by_date method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @room = @hotel.all_rooms[0]

      @hotel.reserve_room(
        @room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Sam"
      )
      @hotel.reserve_room(
        @room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Sam"
      )
      @hotel.reserve_room(
        @room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Sam"
      )
    end

    it "returns an array" do
      expect(@hotel.see_available_rooms_by_date(Date.new(2019, 3, 11), Date.new(2019, 3, 14))).must_be_kind_of Array
    end

    it "returns the correct rooms" do
      expect(@hotel.see_available_rooms_by_date(Date.new(2019, 3, 11), Date.new(2019, 3, 14)).length).must_equal 17
      expect(@hotel.see_available_rooms_by_date(Date.new(2019, 3, 11), Date.new(2019, 3, 14)).first.number).must_equal 4
      expect(@hotel.see_available_rooms_by_date(Date.new(2019, 3, 11), Date.new(2019, 3, 14)).last.number).must_equal 20
      expect(@hotel.see_available_rooms_by_date(Date.new(2019, 3, 11), Date.new(2019, 3, 14))[0].number).must_equal 4
    end
  end

  describe "reserve_room method" do
    let (:hotel) { HotelSystem::Hotel.new }
    let (:room) { hotel.all_rooms[0] }

    it "can add the reservation to the @all_reservations array" do
      hotel.reserve_room(
        room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Sam"
      )
      hotel.reserve_room(
        room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Sam"
      )
      hotel.reserve_room(
        room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Sam"
      )

      expect(hotel.all_reservations.length).must_equal 3
      expect(hotel.all_reservations[0]).must_be_kind_of HotelSystem::Reservation
      expect(hotel.all_reservations[1]).must_be_kind_of HotelSystem::Reservation
      expect(hotel.all_reservations[2]).must_be_kind_of HotelSystem::Reservation
    end

    it "can add the reservation to the assigned room's reservation array" do
      hotel.reserve_room(
        room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Sam"
      )
      expect(room.reservations.length).must_equal 1
      expect(room.reservations[0]).must_be_kind_of HotelSystem::Reservation
    end

    it "can assign a room, that doesn't have other conflicting reservations, to the reservation if the selected room is not available" do
      hotel.reserve_room(
        room,
        Date.new(2019, 3, 10),
        Date.new(2019, 3, 13),
        "Jon"
      )
      hotel.reserve_room(
        room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Sam"
      )
      hotel.reserve_room(
        room,
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        "Dee"
      )

      expect(hotel.all_reservations[0].room.number).must_equal 1
      expect(hotel.all_reservations[1].room.number).must_equal 2
      expect(hotel.all_reservations[2].room.number).must_equal 3
      expect(hotel.all_reservations.length).must_equal 3
    end

    it "raises an error if no rooms are available at all during specified dates" do
      20.times do
        hotel.reserve_room(
          room,
          Date.new(2019, 3, 10),
          Date.new(2019, 3, 13),
          "Jon"
        )
      end

      expect do
        hotel.reserve_room(
          room,
          Date.new(2019, 3, 11),
          Date.new(2019, 3, 14),
          "Zoe"
        )
      end.must_raise ArgumentError
    end
  end

  describe "room_available? method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @hotel.all_rooms.slice!(2..19)

      @reservation1 = HotelSystem::Reservation.new(
        room: 1,
        start_date: Date.new(2019, 3, 10),
        end_date: Date.new(2019, 3, 12),
        guest: "Sam",
      )
      @hotel.all_rooms[0].reservations << @reservation1

      @reservation2 = HotelSystem::Reservation.new(
        room: 2,
        start_date: Date.new(2019, 3, 14),
        end_date: Date.new(2019, 3, 16),
        guest: "Jan",
      )
      @hotel.all_rooms[1].reservations << @reservation2
    end

    it "assigns the first available room" do
      expect(@hotel.room_available?(Date.new(2019, 3, 13), Date.new(2019, 3, 14))).must_equal @hotel.all_rooms[0]
    end

    it "assigns a subsequent room if previous rooms have a conflicting reservation" do
      expect(@hotel.room_available?(Date.new(2019, 3, 11), Date.new(2019, 3, 14))).must_equal @hotel.all_rooms[1]
    end

    it "returns false if no room is available during the specified dates" do
      expect(@hotel.room_available?(Date.new(2019, 3, 11), Date.new(2019, 3, 15))).must_equal false
    end
  end

  describe "hold_block method" do
    before do
      @hotel = HotelSystem::Hotel.new
    end

    let (:already_blocked_room) { HotelSystem::Room.new(number: 1, block_id: "00000") }
    let (:room1) { @hotel.all_rooms[1] }
    let (:room2) { @hotel.all_rooms[2] }
    let (:room3) { @hotel.all_rooms[3] }

    it "raises an error if one of the rooms is already in another block" do
      expect do
        @hotel.hold_block(
          start_date: Date.new(2019, 3, 11),
          end_date: Date.new(2019, 3, 14),
          room_collection: [already_blocked_room, room1, room2],
        )
      end.must_raise ArgumentError
    end

    it "can create an instance of a block" do
      block = @hotel.hold_block(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        [room3, room1, room2]
      )

      expect(@hotel.all_blocks[0]).must_be_kind_of HotelSystem::Block
    end

    it "can change the block id of the rooms in its collection" do
      block = @hotel.hold_block(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        [room3, room1, room2]
      )

      expect(room3.block_id).wont_be_nil
      expect(room1.block_id).wont_be_nil
      expect(room2.block_id).wont_be_nil
    end

    it "can change the price of the rooms in its collection" do
      block = @hotel.hold_block(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        [room3, room1, room2]
      )

      expect(room3.price).must_equal 156.00
      expect(room1.price).must_equal 156.00
      expect(room2.price).must_equal 156.00
    end

    it "can add the instance of a block to the all_blocks array" do
      block = @hotel.hold_block(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        [room3, room1, room2]
      )

      expect(@hotel.all_blocks.length).must_equal 1
      expect(@hotel.all_blocks[0]).must_be_kind_of HotelSystem::Block
    end
  end

  describe "reserve_block_room method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @room1 = @hotel.all_rooms[1]
      @room2 = @hotel.all_rooms[2]
      @room3 = @hotel.all_rooms[3]

      @block = @hotel.hold_block(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        [@room3, @room1, @room2]
      )
    end

    it "can find the block associated with the block id" do
      expect(@hotel.all_blocks.detect { |block| block.id == @room3.block_id }).must_be_kind_of HotelSystem::Block
    end

    it "raises an error if the block id entered isn't associated with any block" do
      expect do
        @hotel.reserve_block_room(
          Date.new(2019, 3, 11),
          Date.new(2019, 3, 14), @room1, "00000", "Sam"
        )
      end.must_raise ArgumentError
    end

    it "can add the reservation to that room's reservation list" do
      @hotel.reserve_block_room(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        @room1, @room1.block_id, "Sam"
      )

      expect(@room1.reservations.length).must_equal 1
    end

    it "can add the reservation to the all_reservations list" do
      @hotel.reserve_block_room(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        @room1, @room1.block_id, "Sam"
      )

      expect(@hotel.all_reservations.length).must_equal 1
    end

    it "can add the reservation to that block's list of reservations" do
      @hotel.reserve_block_room(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        @room1, @room1.block_id, "Sam"
      )

      expect(@hotel.all_blocks.length).must_equal 1
    end

    it "can create an instance of a reservation" do
      @hotel.reserve_block_room(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        @room1, @room1.block_id, "Sam"
      )

      expect(@room1.reservations[0]).must_be_kind_of HotelSystem::Reservation
    end

    it "can change the rooms block id back to nil" do
      @hotel.reserve_block_room(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        @room1, @room1.block_id, "Sam"
      )

      expect(@room1.block_id).must_be_nil
    end

    it "can change the rooms price back to 200" do
      @hotel.reserve_block_room(
        Date.new(2019, 3, 11),
        Date.new(2019, 3, 14),
        @room1, @room1.block_id, "Sam"
      )

      expect(@room1.price).must_equal 200
    end
  end
end
