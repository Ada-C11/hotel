require_relative "spec_helper"

describe "hotel class" do
  before do
    @hotel = HotelGroup::Hotel.new
  end
  describe "initialize" do
    it "returns an object of type HotelGroup::Hotel with instance variables" do
      expect(@hotel).must_be_kind_of HotelGroup::Hotel
      expect(@hotel).must_respond_to :rooms, :reservations
    end

    it "initializes an array of rooms" do
      expect(@hotel.rooms).must_be_kind_of Array
      expect(@hotel.rooms.count).must_equal 20
    end
  end

  describe "creates new reservation" do
    before do
      @hotel = HotelGroup::Hotel.new
      @start_time = Date.new(2019, 3, 9)
      @end_time = Date.new(2019, 3, 11)

      @start_time2 = Date.new(2019, 4, 9)
      @end_time2 = Date.new(2019, 4, 11)
    end

    it "generates an id for the new reservation" do
      expect(@hotel.create_res_id).must_equal 5
    end

    it "creates new HotelGroup::Reservation objects and adds them to reservations array" do
      @hotel.make_reservation(@start_time, @end_time)

      @hotel.make_reservation(@start_time2, @end_time2)

      expect(@hotel.reservations.count).must_equal 6
      expect(@hotel.reservations[0]).must_be_kind_of HotelGroup::Reservation
      expect(@hotel.reservations[1].id).must_equal 2
    end

    it "raises an exception when invalid date range is entered" do
      @end_time_bad = Date.new(2018, 3, 9)

      expect { @hotel.make_reservation(@start_time, @end_time_bad) }.must_raise ArgumentError
    end

    it "finds a reservation" do
      @hotel.make_reservation(@start_time, @end_time)

      id = @hotel.reservations[0].id

      res = @hotel.find_reservation(id)
      expect(res).must_be_kind_of HotelGroup::Reservation
    end
  end

  describe "finds reservations by date" do
    before do
      @hotel = HotelGroup::Hotel.new
      @start_time = Date.new(2019, 3, 9)
      @end_time = Date.new(2019, 3, 11)

      @start_time2 = Date.new(2019, 4, 9)
      @end_time2 = Date.new(2019, 4, 11)

      @start_time3 = Date.new(2019, 3, 10)
      @end_time3 = Date.new(2019, 3, 15)

      @hotel.make_reservation(@start_time, @end_time)
      @hotel.make_reservation(@start_time2, @end_time2)
      @hotel.make_reservation(@start_time3, @end_time3)
    end

    it "adds reservations to an array if they match given date" do
      date = Date.new(2019, 3, 10)
      expect(@hotel.find_by_date(date)).must_be_kind_of Array
      expect(@hotel.find_by_date(date).count).must_equal 2
    end

    it "finds available rooms for a start and end time" do
      expect(@hotel.find_available_rooms(@start_time2, @end_time2).count).must_equal 19
    end
  end

  it "raises an error when no rooms are available" do
    @hotel.rooms = [HotelGroup::Room.new(1, 200)]
    start_date = Date.new(2019, 7, 7)
    end_date = Date.new(2019, 7, 9)
    @hotel.make_reservation(start_date, end_date)

    expect { @hotel.make_reservation(start_date, end_date) }.must_raise ArgumentError
  end

  it "raises an error when invalid room is passed to make_reservation" do
    invalid_room = HotelGroup::Room.new(3, 200)

    @hotel.rooms = [HotelGroup::Room.new(1, 200)]
    start_date = Date.new(2019, 7, 7)
    end_date = Date.new(2019, 7, 9)

    expect { @hotel.make_reservation(start_date, end_date, room: invalid_room) }.must_raise ArgumentError
  end

  describe "hotel block creation" do
    before do
      @hotel = HotelGroup::Hotel.new
      @start_time = Date.new(2019, 3, 9)
      @end_time = Date.new(2019, 3, 11)

      @start_time2 = Date.new(2019, 4, 9)
      @end_time2 = Date.new(2019, 4, 11)

      @start_time3 = Date.new(2019, 3, 10)
      @end_time3 = Date.new(2019, 3, 15)

      @start_time4 = Date.new(2018, 5, 5)
      @end_time4 = Date.new(2018, 5, 10)

      @hotel.make_reservation(@start_time, @end_time)
      @hotel.make_reservation(@start_time2, @end_time2)
      @hotel.make_reservation(@start_time3, @end_time3)
    end
    it "generates a block id" do
      expect(@hotel.create_block_id).must_equal 5
    end

    it "raises an error if one of the rooms is unavailable for the given date range" do
      expect { @hotel.create_hotel_block(@start_time, @end_time, [@hotel.reservations[2].room.number]) }.must_raise ArgumentError
    end

    it "creates HotelGroup::HotelBlock object if rooms are available" do
      block = @hotel.create_hotel_block(@start_time4, @end_time4, [@hotel.rooms[0].number, @hotel.rooms[1].number])

      expect(block).must_be_kind_of HotelGroup::HotelBlock
    end

    it "won't reserve a room that is already part of a block" do
      block = @hotel.create_hotel_block(@start_time4, @end_time4, [@hotel.rooms[0].number, @hotel.rooms[1].number])

      room = @hotel.rooms[0]

      expect { @hotel.make_reservation(@start_time4, @end_time4, room: room) }.must_raise ArgumentError
    end

    it "won't create a block if a room is already part of another block" do
      block = @hotel.create_hotel_block(@start_time4, @end_time4, [@hotel.rooms[0].number, @hotel.rooms[1].number])

      expect { @hotel.create_hotel_block(@start_time4, @end_time4, [@hotel.rooms[0].number]) }.must_raise ArgumentError
    end

    describe "reserve_block_room" do
      before do
        @block_room = @hotel.rooms[8]
        @block = @hotel.create_hotel_block(@start_time4, @end_time4, [@block_room.number])
      end
      it "reserves a block room" do
        @hotel.reserve_block_room(@block_room, @block)

        expect(@hotel.blocks.count).must_equal 6

        expect(@hotel.blocks[0]).must_be_kind_of HotelGroup::HotelBlock
      end

      it "won't reserve_block_room a room that isn't part of the block" do
        non_block_room = @hotel.rooms[9]

        expect { @hotel.reserve_block_room(non_block_room, @block) }.must_raise ArgumentError
      end

      it "won't reserve_block_room a room that is already reserved in the block" do
        @hotel.reserve_block_room(@block_room, @block)

        expect { @hotel.reserve_block_room(@block_room, @block) }.must_raise ArgumentError
      end

      it "adds reservation to room.reservations after reserve_block_room is successfully called" do
        @hotel.reserve_block_room(@block_room, @block)

        expect(@block_room.reservations.count).must_equal 1
      end
    end
  end
  describe "read from CSV" do
    before do
    end
    it "gets the correct number of reservations" do
      expect(@hotel.reservations.count).must_equal 4
    end
  end
end
