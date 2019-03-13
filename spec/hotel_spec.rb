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
      #year, month, day
      reservation_id = 333
      new_reservation = @hotel.reserve_room(reservation_id, Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)
      expect(new_reservation).must_be_kind_of Hotel::Reservation
    end

    it "adds the reservation to the Hotel's list of reservations" do
      #year, month, day
      reservation_id = 333
      new_reservation = @hotel.reserve_room(reservation_id, Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)
      @hotel.add_reservation(new_reservation)
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
    # reserve_room(reservation_id,start_date, end_date,room_ID)
    # before do
    #   @rooms = []
    #   20.times do |k|
    #     @rooms << Hotel::Room.new(id: k)
    #   end
    #   @hotel = Hotel::Hotel.new(
    #     id: 1,
    #     rooms: @rooms,
    #     reservations: [],
    #   )
    it "checks the date range ok" do
      new_reservation = @hotel.reserve_room(333, Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)
      new_reservation2 = @hotel.reserve_room(334, Date.new(2001, 3, 5), Date.new(2001, 3, 7), 1)
      @hotel.add_reservation(new_reservation)
      @hotel.add_reservation(new_reservation2)
      new_reservation.room.add_reservation(new_reservation)
      new_reservation2.room.add_reservation(new_reservation2)
      expect(@hotel.access_reservations(Date.new(2001, 3, 6))[0].id).must_equal 333
    end

    it "Access the list of reservations by date" do
    end
  end

  describe "#available_rooms" do
    before do
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
    end

    it "returns a list of rooms available for a given date range within the reservation date range " do
      start_date = Date.new(2001, 3, 6)
      end_date = Date.new(2001, 3, 8)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "returns a list of rooms available for a given date range outside most reservation date ranges" do
      # new_reservation5 = @hotel.reserve_room(337, Date.new(2001, 3, 4), Date.new(2001, 3, 12), 15)
      # @hotel.add_reservation(new_reservation5)
      start_date = Date.new(2001, 3, 3)
      end_date = Date.new(2001, 3, 6)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "returns a list of rooms available for a given date range with start date at the end date of existing reservations" do
      # new_reservation5 = @hotel.reserve_room(337, Date.new(2001, 3, 4), Date.new(2001, 3, 12), 15)
      # @hotel.add_reservation(new_reservation5)
      start_date = Date.new(2001, 3, 7)
      end_date = Date.new(2001, 3, 10)
      expect(@hotel.available_rooms(start_date, end_date)).must_equal [0, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19]
    end

    it "raises an Argument Error if tries to reserve room that is not available for a given day" do
      expect { @hotel.reserve_room(338, Date.new(2001, 3, 5), Date.new(2001, 3, 17), 0) }.must_raise ArgumentError
    end
  end

  #   describe "#hotel_block" do
  #     before do
  #       new_reservation = @hotel.reserve_room(333, Date.new(2001, 3, 5), Date.new(2001, 3, 7), 0)
  #       new_reservation2 = @hotel.reserve_room(334, Date.new(2001, 3, 5), Date.new(2001, 3, 7), 1)
  #       new_reservation3 = @hotel.reserve_room(335, Date.new(2001, 3, 9), Date.new(2001, 3, 15), 2)
  #       new_reservation4 = @hotel.reserve_room(336, Date.new(2001, 3, 4), Date.new(2001, 3, 12), 12)

  #       @hotel.add_reservation(new_reservation)
  #       @hotel.add_reservation(new_reservation2)
  #       @hotel.add_reservation(new_reservation3)
  #       @hotel.add_reservation(new_reservation4)

  #       new_reservation.room.add_reservation(new_reservation)
  #       new_reservation2.room.add_reservation(new_reservation2)
  #       new_reservation3.room.add_reservation(new_reservation3)
  #       new_reservation4.room.add_reservation(new_reservation4)
  #     end

  #     it "creates a Hotel Block that is added to #hotel_block array" do
  #       # can be a hash

  #       start_date = Date.new(2001, 2, 5)
  #       end_date = Date.new(2001, 2, 10)
  #       collection_rooms = [2, 3, 4, 5]
  #       discounted_rate = 150
  #       hotel_block_reserved = @hotel.reserve_hotel_block(1, start_date, end_date, collection_rooms, discounted_rate)
  #       expect(@hotel.hotel_block.length).must_equal 1
  #       expect(@hotel.hotel_block[0][:collection_rooms]).must_equal collection_rooms
  #     end

  #     it "raises an argument error if tries to create Hotel Block and one of the rooms is unavailable for the given data range" do
  #       start_date = Date.new(2001, 3, 5)
  #       end_date = Date.new(2001, 3, 10)
  #       collection_rooms = [0, 1, 2, 3, 4, 5]
  #       discounted_rate = 150
  #       expect { @hotel.reserve_hotel_block(1, start_date, end_date, collection_rooms, discounted_rate) }.must_raise ArgumentError
  #     end
  #   end
end
