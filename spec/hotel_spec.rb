require_relative "spec_helper"

describe "Hotel class" do
  before do
    @rooms = HotelSystem::Room.make_set(20, 200)
    @new_hotel = HotelSystem::Hotel.new(@rooms)
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
    it "creates an empty hash of reservation objects" do
      expect(@new_hotel.reservations).must_be_instance_of Hash
      expect(@new_hotel.reservations).must_be_empty
    end

    it "creates an empty hash of Block objects" do
      expect(@new_hotel.blocks).must_be_instance_of Hash
      expect(@new_hotel.reservations).must_be_empty
    end
  end
  describe "find room" do
    before do
      @rooms = HotelSystem::Room.make_set(20, 200)
      @new_hotel = HotelSystem::Hotel.new(@rooms)
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
      @rooms = HotelSystem::Room.make_set(20, 200)
      @new_hotel = HotelSystem::Hotel.new(@rooms)
      @new_res = @new_hotel.make_reservation(room_id: 1, start_date: "01 Feb 2020", end_date: "08 Feb 2020", name: "Ada")
      @test_room = @new_hotel.rooms.first
    end
    it "returns a new reservation if the room is available during the given dates" do
      expect(@new_res).must_be_instance_of HotelSystem::Reservation
    end

    it "adds the new reservation to the hotel's collection of reservations" do
      expect(@new_hotel.find_res_by_id(@new_res.id)).must_equal @new_res
    end

    it "adds the new reservation to the room's collection of reservations" do
      expect(@test_room.find_res_by_id(@new_res.id)).must_equal @new_res
    end

    it "allows reservations where the start date is on an existing reservation's end date" do
      test_reservation = @new_hotel.make_reservation(room_id: 1, start_date: "08 Feb 2020", end_date: "15 Feb 2020", name: "Ada")
      expect(test_reservation).must_be_instance_of HotelSystem::Reservation
    end

    it "allows reservations where the end date is on an existing reservation's start date" do
      test_reservation = @new_hotel.make_reservation(room_id: 1, start_date: "08 Jan 2020", end_date: "01 Feb 2020", name: "Ada")
      expect(test_reservation).must_be_instance_of HotelSystem::Reservation
    end

    it "raises an exception if the room is not available during the given dates" do
      expect { @new_hotel.make_reservation(room_id: 1, start_date: "01 Feb 2020", end_date: "08 Feb 2020", name: "Ada") }.must_raise ReservationError
      expect { @new_hotel.make_reservation(room_id: 1, start_date: "04 Feb 2020", end_date: "08 Feb 2020", name: "Ada") }.must_raise ReservationError
      expect { @new_hotel.make_reservation(room_id: 1, start_date: "04 Feb 2020", end_date: "12 Feb 2020", name: "Ada") }.must_raise ReservationError
    end
    it "raises an exception if an invalid room id is given" do
      expect { @new_hotel.make_reservation(room_id: 10000000, start_date: "01 Mar 2020", end_date: "08 Mar 2020", name: "Ada") }.must_raise RoomError
      expect { @new_hotel.make_reservation(room_id: 0, start_date: "01 Mar 2020", end_date: "08 Mar 2020", name: "Ada") }.must_raise RoomError
      expect { @new_hotel.make_reservation(room_id: -5, start_date: "01 Mar 2020", end_date: "08 Mar 2020", name: "Ada") }.must_raise RoomError
    end
    it "raises an exception if the dates given are invalid" do
      expect {
        @new_hotel.make_reservation(room_id: 1, start_date: "08 Feb 2020", end_date: "01 Feb 2020", name: "Ada")
      }.must_raise DateRangeError
    end
  end

  describe "list reservations by date" do
    before do
      @rooms = HotelSystem::Room.make_set(20, 200)
      @new_hotel = HotelSystem::Hotel.new(@rooms)
      @new_res = @new_hotel.make_reservation(room_id: 1, start_date: "01 Feb 2020", end_date: "08 Feb 2020", name: "Ada")
      @date = Date.parse("04 Feb 2020")
      @reservations_on_date = @new_hotel.reservations_by_date("04 Feb 2020")
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
      @rooms = HotelSystem::Room.make_set(20, 200)
      @new_hotel = HotelSystem::Hotel.new(@rooms)
      @new_hotel.make_reservation(room_id: 1, start_date: "01 Feb 2020", end_date: "08 Feb 2020", name: "Ada")
      @avail_rooms = @new_hotel.list_available_rooms("04 Feb 2020")
      @total_rooms = @new_hotel.rooms.length
    end
    it "returns an array of rooms" do
      expect(@avail_rooms).must_be_instance_of Array
      @avail_rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
    end
    it "excludes reserved rooms" do
      reserved_room = @new_hotel.find_room_by_id(1)

      expect(@avail_rooms).wont_include reserved_room
      expect(@avail_rooms.length).must_equal (@total_rooms - 1)
    end
    it "excludes blocked rooms if exclude_blocked parameter is true" do
      @new_hotel.make_block(3, 4, 5, start_date: "01 Feb 2020",
                                     end_date: "10 Feb 2020",
                                     discount_rate: 180,
                                     group_name: "ComicCon")
      blocked_room = @new_hotel.find_room_by_id(3)

      avail_rooms = @new_hotel.list_available_rooms("04 Feb 2020")

      expect(avail_rooms).wont_include blocked_room
      expect(avail_rooms.length).must_equal (@total_rooms - 4)
    end
    it "includes blocked rooms if exclude_blocked parameter is false" do
      @new_hotel.make_block(3, 4, 5, start_date: "01 Feb 2020",
                                     end_date: "10 Feb 2020",
                                     discount_rate: 180,
                                     group_name: "ComicCon")
      blocked_room = @new_hotel.find_room_by_id(3)
      avail_rooms = @new_hotel.list_available_rooms("04 Feb 2020", exclude_blocked = false)

      expect(avail_rooms).must_include blocked_room
      expect(avail_rooms.length).must_equal (@total_rooms - 1)
    end
  end
  describe "reserve from block" do
    before do
      @rooms = HotelSystem::Room.make_set(20, 200)
      @hotel = HotelSystem::Hotel.new(@rooms)
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @block = @hotel.make_block(1, 2, 3, 4, 5, start_date: "01 Feb 2020",
                                                end_date: "10 Feb 2020",
                                                discount_rate: 180,
                                                group_name: "ComicCon")
      @room = @block.rooms[0]
      @block_reservation = @hotel.reserve_from_block(@block.id, 1, "Ada")
    end
    it "will return a new reservation for a room within the block" do
      expect(@block_reservation).must_be_instance_of HotelSystem::Reservation
    end
    it "will add the new reservation to the hotel's list of reservations" do
      expect(@hotel.find_res_by_id(@block_reservation.id)).must_equal @block_reservation
    end
    it "will add the reservation to the room's list of reservations" do
      expect(@room.find_res_by_id(@block_reservation.id)).must_equal @block_reservation
    end
    it "will add the reservation to the block's list of reservations" do
      expect(@block.find_res_by_id(@block_reservation.id)).must_equal @block_reservation
    end
    it "will set the reservation's date range equal to the block's date range" do
      expect(@block_reservation.date_range).must_equal @block.date_range
    end

    it "will apply the discount to the total cost of the reservation" do
      expected_cost = @date_range.length * @block.discount_rate
      expect(@block_reservation.total_cost).must_equal expected_cost
    end

    it "will raise an exception if reserving a room that is not within the block" do
      expect {
        @hotel.reserve_from_block(@block.id, 7, "Ada")
      }.must_raise BlockError
    end

    it "will raise an exception if reserving a room that is reserved for the date" do
      expect {
        @hotel.reserve_from_block(@block.id, 1, "Ada")
      }.must_raise ReservationError
    end
  end
  describe "make block" do
    before do
      @rooms = HotelSystem::Room.make_set(20, 200)
      @hotel = HotelSystem::Hotel.new(@rooms)
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @new_block = @hotel.make_block(1, 2, 3, 4, 5, start_date: "01 Feb 2020",
                                                    end_date: "10 Feb 2020",
                                                    group_name: "Ada Academy",
                                                    discount_rate: 180)
    end
    it "returns a new block if all rooms are available during the given date range" do
      expect(@new_block).must_be_instance_of HotelSystem::Block
    end
    it "raises an exception if one or more rooms have overlapping reservations" do
      @hotel.make_reservation(room_id: 6, start_date: "01 Feb 2020", end_date: "08 Feb 2020", name: "Ada")
      expect {
        @hotel.make_block(6, 7, 8, 9, 10, start_date: "01 Feb 2020",
                                          end_date: "10 Feb 2020",
                                          group_name: "Ada Academy",
                                          discount_rate: 180)
      }.must_raise ReservationError
    end
    it "raises an exception if one or more rooms have overlapping blocks" do
      expect {
        @hotel.make_block(3, 4, 5, 6, 7, start_date: "01 Feb 2020",
                                         end_date: "10 Feb 2020",
                                         group_name: "Ada Academy",
                                         discount_rate: 180)
      }.must_raise BlockError
    end
    it "adds the block to each room's collection of blocks" do
      @new_block.rooms.each do |room|
        expect(room.find_block_by_id(@new_block.id)).must_equal @new_block
        expect(room.is_blocked?(@date_range)).must_equal true
      end
    end
    it "adds the block to the hotel's collection of blocks" do
      expect(@hotel.find_block_by_id(@new_block.id)).must_equal @new_block
    end
    it "raises an exception if invalid dates are given" do
      expect {
        @hotel.make_block(8, 9, 10, start_date: "10 Feb 2020",
                                    end_date: "01 Feb 2020",
                                    group_name: "Ada Academy",
                                    discount_rate: 180)
      }.must_raise DateRangeError
    end
  end
end
