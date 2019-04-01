require_relative 'spec_helper'

describe "Booking" do
  before do
    @booking = Hotel::Booking.new
    @booking.rooms = Hotel::Room.list_rooms(1, 20, 200)
  end

  describe "#initialize" do
    it "Is an instance of Booking" do
      expect(@booking).must_be_kind_of Hotel::Booking
    end
  end

  describe "request_reservation" do
    before do 
      @request = @booking.request_reservation("April 1, 2020", "April 5, 2020")
    end
    it "Returns an instance of Reservation" do
      expect(@request).must_be_kind_of Hotel::Reservation
    end

    it "Associates a Room with a Reservation" do
      expect(@request.room).must_be_kind_of Hotel::Room
    end

    it "Associates a Reservation with a Room" do
      expect(@request.room.reservations.first).must_be_kind_of Hotel::Reservation
    end
  end

  describe "check_availability" do
    it "Returns an instance of room if one is available" do
      request = @booking.check_availability("April 1, 2020", "April 5, 2020")
      expect(request.first).must_be_kind_of Hotel::Room
    end

    it "Returns the first room that is available" do
      # this reservation should take room 1
      @booking.request_reservation("April 1, 2020", "April 5, 2020")
      request = @booking.check_availability("April 1, 2020", "April 5, 2020")
      expect(request.first.id).must_equal 2
    end

    it "Raises an error if there are no available rooms for a given date range" do
      20.times do
        @booking.request_reservation("April 1, 2020", "April 5, 2020")
      end
      expect {
        @booking.check_availability("April 1, 2020", "April 5, 2020")
      }.must_raise Hotel::Booking::UnavailableRoomError
    end
  end

  describe "find_reservation" do
    before do
      @booking.request_reservation("May 1, 2020", "May 5, 2020")
      @booking.request_reservation("May 3, 2020", "May 5, 2020")
    end

    it "Returns a collection of Reservations for a specific date" do
      res_date = @booking.find_reservation("May 3, 2020")
      expect(res_date).must_be_kind_of Array
      expect(res_date.first).must_be_kind_of Hotel::Reservation
      expect(res_date.length).must_equal 2
    end

    it "Omits reservations that don't include the date" do
      @booking.request_reservation("June 3, 2020", "June 5, 2020")
      res_date = @booking.find_reservation("May 3, 2020")
      expect(res_date.length).must_equal 2
    end
  end

  describe "get_rooms" do
    it "Returns a collection of available rooms" do
      rooms = @booking.get_rooms("April 10, 2020", "April 15, 2020", 3)
      expect(rooms).must_be_kind_of Array
      expect(rooms.first).must_be_kind_of Hotel::Room
      expect(rooms.length).must_equal 3
    end

    it "Raises an error when getting rooms if at least one of the rooms is already reserved during the date range" do
      19.times do
        @booking.request_reservation("April 1, 2020", "April 5, 2020")
      end
      expect {
        @booking.get_rooms("April 1, 2020", "April 5, 2020", 2)
      }.must_raise Hotel::Booking::UnavailableRoomError
    end
  end

  describe "create_block" do
    before do
      @rooms = @booking.get_rooms("April 10, 2020", "April 15, 2020", 3)
    end
    it "adds a block to @blocks" do
      expect(@booking.blocks).must_equal []
      @booking.create_block("April 10, 2020", "April 15, 2020", @rooms, 175)
      expect(@booking.blocks.length).must_equal 1
      expect(@booking.blocks.first).must_be_kind_of Hotel::Block
      expect(@booking.blocks.first.rooms.length).must_equal 3
    end

    it "Raises an error when creating a block if at least one of the rooms is already in a block during the date range" do
      @booking.create_block("April 10, 2020", "April 15, 2020", @rooms, 150)
      expect {
        @booking.create_block("April 10, 2020", "April 15, 2020", @rooms, 150)
      }.must_raise Hotel::Block::BlockBookingError
    end
  end

  describe "further availability checks" do
    it "Allows a reservation to be made that starts on the same day another reservation for the same room ends" do
      @booking.request_reservation("April 10, 2020", "April 15, 2020")
      request = @booking.request_reservation("April 15, 2020", "April 17, 2020")
      expect(request.room.id).must_equal 1
    end

    it "Allows a reservation to be made that ends on the same day another reservation in the same room begins" do
      @booking.request_reservation("April 10, 2020", "April 15, 2020")
      request = @booking.request_reservation("April 7, 2020", "April 10, 2020")
      expect(request.room.id).must_equal 1
    end

    it "Allows a reservation to be made after another reservation ends in the same room" do
      @booking.request_reservation("April 10, 2020", "April 15, 2020")
      request = @booking.request_reservation("April 17, 2020", "April 20, 2020")
      expect(request.room.id).must_equal 1
    end

    it "Allows a reservation to be made before another reservation starts in the same room" do
      @booking.request_reservation("April 10, 2020", "April 15, 2020")
      request = @booking.request_reservation("April 3, 2020", "April 7, 2020")
      expect(request.room.id).must_equal 1
    end

    it "Raises an error if there are no available rooms for the same date range" do
      20.times do
        @booking.request_reservation("April 10, 2020", "April 15, 2020")
      end
      expect {
        @booking.request_reservation("April 10, 2020", "April 15, 2020")
      }.must_raise Hotel::Booking::UnavailableRoomError
    end

    it "Raises an error if a reservation is requested that starts during a time range where no rooms are available" do
      20.times do
        @booking.request_reservation("April 10, 2020", "April 15, 2020")
      end
      expect {
        @booking.request_reservation("April 12, 2020", "April 18, 2020")
      }.must_raise Hotel::Booking::UnavailableRoomError
    end
    
    it "Raises an error if a reservation is requested that ends during a time range where no rooms are available" do
      20.times do
        @booking.request_reservation("April 10, 2020", "April 15, 2020")
      end
      expect {
        @booking.request_reservation("April 6, 2020", "April 13, 2020")
      }.must_raise Hotel::Booking::UnavailableRoomError
    end

    it "Raises an error if the reservation request starts and ends after a date range where no rooms are available" do
      20.times do
        @booking.request_reservation("April 10, 2020", "April 15, 2020")
      end
      expect {
        @booking.request_reservation("April 6, 2020", "April 18, 2020")
      }.must_raise Hotel::Booking::UnavailableRoomError
    end

    it "Raises an error if the reservation request starts and ends in the middle of a date range where no rooms are available" do
      20.times do
        @booking.request_reservation("April 10, 2020", "April 15, 2020")
      end
      expect {
        @booking.request_reservation("April 11, 2020", "April 13, 2020")
      }.must_raise Hotel::Booking::UnavailableRoomError
    end
  end

  describe "reservations involving blocks" do
    before do
      @rooms = @booking.get_rooms("April 10, 2020", "April 15, 2020", 3)
    end
    it "Raises an error if trying to make a standard reservation for a room that is part of a block" do
      @booking.create_block("April 10, 2020", "April 15, 2020", @rooms, 175)
      expect {
        @booking.request_reservation("April 11, 2020", "April 13, 2020", 1)
      }.must_raise Hotel::Booking::UnavailableRoomError
    end

    it "Allows a reservation to be made if the room is not part of a block or already reserved" do
      @booking.create_block("April 10, 2020", "April 15, 2020", @rooms, 175)
      # No reservations
      expect(@booking.reservations).must_equal []
      reservation = @booking.request_reservation("April 11, 2020", "April 13, 2020", 5)
      expect(@booking.reservations.length).must_equal 1
    end

    it "Will be included with reservations returned from find_reservation" do
      block = @booking.create_block("April 10, 2020", "April 15, 2020", @rooms, 175)
      reservation = @booking.reserve_from_block(block, 1)
      res_list = @booking.find_reservation("April 10, 2020")
      expect(res_list.first).must_equal reservation
    end
  end

  describe "reserve_from_block" do
    it "makes a reservation for a specific room set aside in a block" do
      @rooms = @booking.get_rooms("April 10, 2020", "April 15, 2020", 3)
      block = @booking.create_block("April 10, 2020", "April 15, 2020", @rooms, 175)
      reservation = @booking.reserve_from_block(block, 1)
      expect(@booking.reservations.first).must_equal reservation
    end
  end
end
