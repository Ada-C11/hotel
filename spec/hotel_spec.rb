require_relative "spec_helper"

describe "Hotel" do
  before do
    @hotel = HotelSystem::Hotel.new(id: 1)
  end
  describe "initialize" do
    it "Creates an instance of a Hotel" do
      expect(@hotel).must_be_kind_of HotelSystem::Hotel
    end

    it "Creates a hotel with default parameters" do
      expect(@hotel.reservations).must_be_kind_of Array
      expect(@hotel.rooms).must_be_kind_of Array
      expect(@hotel.blocks).must_be_kind_of Array
    end
  end

  describe "#list_rooms" do
    before do
      @new_room = HotelSystem::Room.new(id: 1)
    end

    it "returns empty array if there are no rooms in rooms array" do
      expect(@hotel.list_rooms).must_equal []
    end

    it "Can access information about the rooms in the array of rooms" do
      @hotel.rooms << @new_room
      expect(@hotel.rooms.last.id).must_equal @new_room.id
      expect(@hotel.rooms.last).must_be_kind_of HotelSystem::Room
    end

    it "returns an array listing the number of each room in the hotel" do
      @hotel.rooms << @new_room
      room_list = @hotel.list_rooms
      expect(room_list).must_be_kind_of Array
      expect(room_list.first).must_equal 1
    end
  end
  describe "hotel reservations and avaiability" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      @room_two = HotelSystem::Room.new(id: 2)
      @room_three = HotelSystem::Room.new(id: 3)
      @room_four = HotelSystem::Room.new(id: 4)
      @room_five = HotelSystem::Room.new(id: 5)

      @hotel.rooms << @room
      @hotel.rooms << @room_two
      @hotel.rooms << @room_three

      @arrive_day = "2019-02-10"
      @depart_day = "2019-02-14"

      @hotel.book_reservation(@room, @arrive_day, @depart_day)
      @hotel.book_reservation(@room_two, @arrive_day, @depart_day)
    end

    describe "#reservations_by_date" do
      before do
        @reg_res = @hotel.add_reservation(create_reservation(@room, Date.parse("2019-02-06"), Date.parse("2019-02-09")))
      end
      it "returns an array of reservations" do
        reservation_list = @hotel.reservations_by_date("2019-02-10")

        expect(reservation_list).must_be_kind_of Array
        expect(reservation_list.first).must_be_kind_of HotelSystem::Reservation
      end

      it "Does not return reservations that do not contain specified date" do
        reservation_list = @hotel.reservations_by_date("2019-02-10")
        expect(reservation_list.length).must_equal 2
        expect(reservation_list).wont_include @reg_res
      end

      it "returns an empty array if no reservations are found for that date" do
        reservation_list = @hotel.reservations_by_date("2018-02-10")
        expect(reservation_list).must_equal []
      end
    end
    describe "Reservations by date including block_reservations " do
      before do
        @block = @hotel.create_block([@room_four, @room_five], @arrive_day, @depart_day, 0.2)
        # @block.create_block_reservations
      end
      it "will NOT return block reservations that have a status of :AVAILABLE" do
        @block.create_block_reservations
        reservation_list = @hotel.reservations_by_date("2019-02-10")
        expect(reservation_list.length).must_equal 2
        @block.reservations.each do |reservation|
          expect(reservation_list).wont_include reservation
          expect(reservation.status).must_equal :AVAILABLE
        end
      end

      it "will return block reservations that have a status of :UNAVAILABLE" do
        available_reservations = @block.find_available_reservations
        available_reservations.each do |res|
          @block.book_block_reservation(res)
        end
        reservation_list = @hotel.reservations_by_date("2019-02-10")
        expect(reservation_list.length).must_equal 4
        @block.reservations.each do |res|
          expect(reservation_list).must_include res
        end
      end
    end
  end

  describe "get_available_rooms" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      @hotel.rooms << @room

      @way_before = "2016-11-07"
      @before = "2016-11-11"
      @start = "2016-11-13"
      @first_mid = "2016-11-15"
      @second_mid = "2016-11-17"
      @end = "2016-11-19"
      @after = "2016-11-21"
      @way_after = "2016-11-25"

      @hotel.book_reservation(@room, @start, @end)
    end
    it "Returns an array of Rooms" do
      available_rooms = @hotel.get_available_rooms(@way_before, @before)
      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.first).must_be_kind_of HotelSystem::Room
      expect(available_rooms.length).must_equal 1
    end

    it "Returns rooms that have no conflicting reservations" do
      available_rooms = @hotel.get_available_rooms(@way_before, @before)
      expect(available_rooms.length).must_equal 1
    end

    it "Returns rooms that are avaiable, but were occupied the previous night" do
    end

    it "Doesn't return rooms that have conflicting reservations" do
      available_rooms = @hotel.get_available_rooms("2019-2-12", "2019-2-17")
      expect(available_rooms.length).must_equal 1
    end
  end

  describe "hotel#book_reservation" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      # @room_two = HotelSystem::Room.new(id: 2)
      @hotel.rooms << @room
      # @hotel.rooms << @room_two

      @way_before = "2016-11-07"
      @before = "2016-11-11"
      @start = "2016-11-13"
      @first_mid = "2016-11-15"
      @second_mid = "2016-11-17"
      @end = "2016-11-19"
      @after = "2016-11-21"
      @way_after = "2016-11-25"

      @hotel.book_reservation(@room, @start, @end)
      # @hotel.book_reservation(@room_two, @start, @end)
    end
    it "Adds reservation to hotel reservations array" do
      expect(@hotel.reservations.length).must_equal 1
      expect(@hotel.reservations.first).must_be_kind_of HotelSystem::Reservation
    end

    it "Adds reservation to the rooms reservation array" do
      expect(@room.reservations.length).must_equal 1
      expect(@room.reservations.first).must_be_kind_of HotelSystem::Reservation
    end

    describe "Raises an ArgumentError if trying to book a room that is unavailable" do
      it "Rejects a reservation with the same start and end date" do
        expect {
          @hotel.book_reservation(@room, @start, @end)
        }.must_raise ArgumentError
      end

      it "Rejects a reservation with a start date before and the end date in the middle of another reservation" do
        expect {
          @hotel.book_reservation(@room, @start, @first_mid)
        }.must_raise ArgumentError
      end
      it "Rejects a reservation with a start date in the middle and the end after another reservation" do
        expect {
          @hotel.book_reservation(@room, @start, @first_mid)
        }.must_raise ArgumentError
      end

      it "Rejects a reservation with a start date before and the end date after the end of another reservation" do
        expect {
          @hotel.book_reservation(@room, @start, @first_mid)
        }.must_raise ArgumentError
      end
    end
    describe "Accepts available rooms" do
      it "Accepts booking a room with a reservation that starts on the day another ends " do
        hotel_reservation = @hotel.book_reservation(@room, @way_before, @before)
        expect(@room.reservations).must_include hotel_reservation
      end
      it "Accepts booking a room with a reservation that ends on the day another starts" do
        hotel_reservation = @hotel.book_reservation(@room, @after, @way_after)
        expect(@room.reservations).must_include hotel_reservation
      end

      it "Accepts booking a room with a reservation that ends on the day another starts" do
        hotel_reservation = @hotel.book_reservation(@room, @after, @way_after)
        expect(@hotel.reservations).must_include hotel_reservation
        expect(@room.reservations).must_include hotel_reservation
      end
    end
  end

  describe "Managing Blocks" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      @room_two = HotelSystem::Room.new(id: 2)
      @room_three = HotelSystem::Room.new(id: 3)
      @room_array = [@room, @room_two, @room_three]

      @arrive_day = "2019-02-10"
      @depart_day = "2019-02-14"

      @discount = 0.2
    end
    describe "create_block" do
      it "Can be called on a hotel" do
        expect(@hotel).must_respond_to :create_block
      end
      it "creates an instance of a Block" do
        block = @hotel.create_block(@room_array, @arrive_day, @depart_day, 0.2)
        expect(block).must_be_kind_of HotelSystem::Block
      end

      it "Adds the created block to the hotels blocks array" do
        expect(@hotel.blocks.length).must_equal 0
        block = @hotel.create_block(@room_array, @arrive_day, @depart_day, 0.2)
        expect(@hotel.blocks.length).must_equal 1
        expect(@hotel.blocks.first).must_equal block
      end

      ### MAYBE MORE TESTS
      it "Reserves all rooms in the block for the time frame, so they cannot get booked through normal means" do
        block = @hotel.create_block(@room_array, @arrive_day, @depart_day, 0.2)
        @room_array.each do |room|
          expect {
            @hotel.book_reservation(@room, @arrive_day, @depart_day)
          }.must_raise ArgumentError
        end
      end

      #### MAYBE MORE TESTS
      it "cannot book another block that includes any rooms that are included in another block for the same night" do
        block = @hotel.create_block(@room_array, @arrive_day, @depart_day, 0.2)
        expect {
          @hotel.create_block([@room_two, @room_three], "2019-02-12", "2019-02-17", 0.2)
        }.must_raise ArgumentError
      end
    end
  end
end
