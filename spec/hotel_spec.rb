require_relative "spec_helper"
require "Date"
describe "Hotel class" do
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
  describe "Hotel instantiation" do
    it "is an instance of Hotel" do
      expect(@hotel).must_be_kind_of Hotel::Hotel
    end

    it "returns an array of length 20 rooms in rooms attribute" do
      expect(@hotel.rooms.length).must_equal 20
    end

    it "returns an empty array of reservations when hotel first initialized" do
      expect(@hotel.reservations.length).must_equal 0
    end

    it "contains an empty array hotel_block" do
      expect(@hotel.hotel_blocks).must_be_kind_of Array
      expect(@hotel.hotel_blocks.length).must_equal 0
    end
  end

  describe "#reserve_room" do
    it "can create a reservation" do
      new_reservation = @hotel.reserve_room(Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)
      expect(new_reservation).must_be_kind_of Hotel::Reservation
    end

    it "adds the reservation to the Hotel's list of reservations" do
      new_reservation = @hotel.reserve_room(Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)
      expect(@hotel.reservations.length).must_equal 1
    end
  end

  describe "#find_room" do
    it "returns object associated with room id" do
      expect(@hotel.find_room(0)).must_be_kind_of Hotel::Room
    end

    it "returns the correct room id" do
      expect(@hotel.find_room(0).id).must_equal 0
    end
  end

  describe "#access_reservations" do
    it "accesses a reservation correctly" do
      new_reservation = @hotel.reserve_room(Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)
      new_reservation2 = @hotel.reserve_room(Date.new(2001, 3, 5), Date.new(2001, 3, 7), 1)
      expect(@hotel.access_reservations(Date.new(2001, 3, 6))[0].room.id).must_equal 0
    end
  end

  describe "#available_rooms" do
    before do
      new_reservation = @hotel.reserve_room(Date.new(2001, 3, 4), Date.new(2001, 3, 12), 12)
    end
    it "desired reservation dates equal to existing reservation dates" do
      start_date = Date.new(2001, 3, 4)
      end_date = Date.new(2001, 3, 12)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end
    it "desired reservation within existing reservation dates" do
      start_date = Date.new(2001, 3, 6)
      end_date = Date.new(2001, 3, 8)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservation starts before and ends during existing reservation " do
      # new_reservation5 = @hotel.reserve_room(337, Date.new(2001, 3, 4), Date.new(2001, 3, 12), 15)
      # @hotel.add_reservation(new_reservation5)
      start_date = Date.new(2001, 3, 2)
      end_date = Date.new(2001, 3, 6)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservation starts before and ends on existing reservation" do
      start_date = Date.new(2001, 3, 2)
      end_date = Date.new(2001, 3, 12)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservation starts during and ends after existing reservation" do
      start_date = Date.new(2001, 3, 6)
      end_date = Date.new(2001, 3, 15)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservation starts before and ends after existing reservation" do
      start_date = Date.new(2001, 3, 2)
      end_date = Date.new(2001, 3, 15)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservation starts during and ends on existing reservation" do
      start_date = Date.new(2001, 3, 6)
      end_date = Date.new(2001, 3, 12)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservation begins and ends before existing reservation" do
      start_date = Date.new(2001, 3, 2)
      end_date = Date.new(2001, 3, 4)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservation begins at end date of existing reservation and continues " do
      start_date = Date.new(2001, 3, 12)
      end_date = Date.new(2001, 3, 15)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservations begins and ends before existing reservation" do
      start_date = Date.new(2001, 3, 1)
      end_date = Date.new(2001, 3, 3)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
    end

    it "desired reservation to begin and end after existing reservation ends" do
      start_date = Date.new(2001, 3, 13)
      end_date = Date.new(2001, 3, 16)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
    end

    it "existing reservation begins and ends reservation" do
      start_date = Date.new(2001, 3, 7)
      end_date = Date.new(2001, 3, 10)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "raises an Argument Error if tries to reserve room that is not available for a given day" do
      expect { @hotel.reserve_room(Date.new(2001, 3, 5), Date.new(2001, 3, 17), 12) }.must_raise ArgumentError
    end
  end

  describe "#reserve_hotel_block" do
    before do
      new_reservation = @hotel.reserve_room(Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)

      @collection_rooms = [@rooms[0], @rooms[1], @rooms[2], @rooms[3], @rooms[4]]
      start_date = Date.new(2001, 2, 5)
      end_date = Date.new(2001, 2, 10)
      @discounted_rate = 150
      @hotel_block_reserved = @hotel.reserve_hotel_block(1, start_date, end_date, @collection_rooms, @discounted_rate)
      expect(@hotel_block_reserved).must_be_kind_of Hotel::Block
      @collection_rooms.each do |room|
        room.add_block(@hotel_block_reserved)
      end
    end
    it "raises an argument error if tries to create Hotel Block and one of the rooms is reserved for the given date range" do
      start_date = Date.new(2001, 3, 5)
      end_date = Date.new(2001, 3, 10)
      expect { @hotel.reserve_hotel_block(1, start_date, end_date, @collection_rooms, @discounted_rate) }.must_raise ArgumentError
    end

    it "raises an error if tries to reserve a room that is set aside in a hotel block" do
      start_date = Date.new(2001, 2, 6)
      end_date = Date.new(2001, 2, 10)
      expect { @hotel.reserve_room(start_date, end_date, @collection_rooms[0].id) }.must_raise ArgumentError
    end

    it "raises an error if tries to create a hotel block that includes a room that is already set aside in another hotel block for one of those days" do
      @new_collection = [@collection_rooms[0], @rooms[5]]
      start_date = Date.new(2001, 2, 6)
      end_date = Date.new(2001, 2, 10)
      expect { @hotel.reserve_hotel_block(1, start_date, end_date, @new_collection, @discounted_rate) }.must_raise ArgumentError
    end

    it "is able to set aside a hotel block when the end date of one hotel block overlaps with the start date of another hotel block" do
      @new_collection = [@collection_rooms[0], @rooms[5]]
      start_date = Date.new(2001, 2, 10)
      end_date = Date.new(2001, 2, 17)
      expect (@hotel.reserve_hotel_block(1, start_date, end_date, @new_collection, @discounted_rate)).must_be_kind_of Hotel::Block
    end

    describe "#add_hotel_block" do
      it "adds block to hotel instance variable @hotel_block" do
        @hotel.add_hotel_block(@hotel_block_reserved)
        expect(@hotel.hotel_blocks.length).must_equal 1
        expect(@hotel.hotel_blocks[0]).must_be_kind_of Hotel::Block
      end
    end
  end
end
