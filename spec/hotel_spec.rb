require_relative "spec_helper"

describe "Hotel class" do
  before do
    @new_hotel = HotelSystem::Hotel.new
  end
  describe "initialize" do
    it "initializes a Hotel object" do
      expect(@new_hotel).must_be_instance_of HotelSystem::Hotel
    end
    it "creates an array of Room objects" do
      expect(@new_hotel.rooms).must_be_instance_of Array
      @new_hotel.rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
    end
    it "creates an empty array of reservation objects" do
      expect(@new_hotel.reservations).must_be_instance_of Array
      expect(@new_hotel.reservations).must_be_empty
    end
  end
  describe "find room" do
    before do
      @new_hotel = HotelSystem::Hotel.new
    end
    it "will find a room when given a number between 1 and 20" do
      expect (@new_hotel.find_room_by_id(1)).must_be_instance_of HotelSystem::Room
    end
    it "will return nil if given an id that isn't between 1 and 20" do
      expect (@new_hotel.find_room_by_id(21)).must_be_nil
    end
  end
  describe "make reservation" do
    before do
      @new_hotel = HotelSystem::Hotel.new
      @new_res = @new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020")
      @test_room = @new_hotel.rooms.first
    end
    it "returns a new reservation if the room is available during the given dates" do
      expect(@new_res).must_be_instance_of HotelSystem::Reservation
    end

    it "adds the new reservation to the hotel's list of reservations" do
      expect(@new_hotel.reservations).must_include @new_res
    end

    it "adds the new reservation to the room's list of reservations" do
      expect(@test_room.reservations).must_include @new_res
    end

    it "allows reservations where the start date is on an existing reservation's end date" do
      test_reservation = @new_hotel.make_reservation(1, "08 Feb 2020", "15 Feb 2020")
      expect(test_reservation).must_be_instance_of HotelSystem::Reservation
    end

    it "allows reservations where the end date is on an existing reservation's start date" do
      test_reservation = @new_hotel.make_reservation(1, "08 Jan 2020", "01 Feb 2020")
      expect(test_reservation).must_be_instance_of HotelSystem::Reservation
    end

    it "raises an exception if the room is not available during the given dates" do
      expect { @new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020") }.must_raise ReservationError
      expect { @new_hotel.make_reservation(1, "04 Feb 2020", "08 Feb 2020") }.must_raise ReservationError
      expect { @new_hotel.make_reservation(1, "04 Feb 2020", "12 Feb 2020") }.must_raise ReservationError
    end
    it "raises an exception if an invalid room id is given" do
      expect { @new_hotel.make_reservation(10000000, "01 Mar 2020", "08 Mar 2020") }.must_raise RoomError
      expect { @new_hotel.make_reservation(0, "01 Mar 2020", "08 Mar 2020") }.must_raise RoomError
      expect { @new_hotel.make_reservation(-5, "01 Mar 2020", "08 Mar 2020") }.must_raise RoomError
    end
    it "raises an ArgumentError if the dates given are invalid" do
      expect {
        @new_hotel.make_reservation(1, "08 Feb 2020", "01 Feb 2020")
      }.must_raise DateRangeError
    end
  end
  describe "list reservations by date" do
    before do
      @new_hotel = HotelSystem::Hotel.new
      @new_res = @new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020")
      @date = Date.parse("04 Feb 2020")
      @reservations_on_date = @new_hotel.list_reservations_by_date("04 Feb 2020")
    end
    it "will return an array of Reservation objects" do
      expect(@reservations_on_date).must_be_instance_of Array
      @reservations_on_date.each do |reservation|
        expect(reservation).must_be_instance_of HotelSystem::Reservation
      end
    end
    it "will return reservations where the DateRange includes the given date" do
      expect(@reservations_on_date).must_include @new_res
      @reservations_on_date.each do |reservation|
        expect(reservation.date_range.dates).must_include @date
      end
    end
  end
  describe "list available rooms" do
    before do
      @new_hotel = HotelSystem::Hotel.new
      @new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020")
      @avail_rooms = @new_hotel.list_available_rooms("04 Feb 2020")
    end
    it "returns an array of rooms" do
      expect(@avail_rooms).must_be_instance_of Array
      @avail_rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
    end
    it "excludes reserved rooms" do
      reserved_room = @new_hotel.find_room_by_id(1)
      total_rooms = @new_hotel.rooms.length

      expect(@avail_rooms).wont_include reserved_room
      expect(@avail_rooms.length).must_equal (total_rooms - 1)
    end
  end
  describe "reserve from block" do
    before do
      @hotel = HotelSystem::Hotel.new
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @block = HotelSystem::Block.new(date_range: @date_range,
                                      rooms: @hotel.rooms[0...5],
                                      discount_rate: 180)
      @room = @block.rooms[0]
      @block_reservation = @hotel.reserve_from_block(@block, @room)
    end
    it "will return a new reservation for a room within the block" do
      expect(@block_reservation).must_be_instance_of HotelSystem::Reservation
    end
    it "will add the new reservation to the hotel's list of reservations" do
      expect(@hotel.reservations).must_include @block_reservation
    end
    it "will add the reservation to the room's list of reservations" do
      expect(@room.reservations).must_include @block_reservation
    end
    it "will add the reservation to the block's list of reservations" do
      expect(@room.reservations).must_include @block_reservation
    end
    it "will set the reservation's date range equal to the block's date range" do
      expect(@block_reservation.date_range).must_equal @block.date_range
    end

    it "will apply the discount to the total cost of the reservation" do
      expected_cost = @date_range.length * @block.discount_rate
      expect(@block_reservation.total_cost).must_equal expected_cost
    end

    it "will raise an exception if reserving a room that is not within the block" do
      my_room = HotelSystem::Room.new(id: 21, rate: 200)
      expect {
        @hotel.reserve_from_block(@block, my_room)
      }.mustRaise BlockError
    end

    it "will raise an exception if reserving a room that is reserved for the date" do
      expect {
        @hotel.reserve_from_block(@block, @room)
      }.mustRaise ReservationError
    end
  end
end
