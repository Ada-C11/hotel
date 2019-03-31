require_relative "spec_helper"

describe "Block" do
  describe "initialize" do
    before do
      @rooms = []
      @arrive_day = Date.parse("2019-01-01")
      @depart_day = Date.parse("2019-01-06")
      @discount = 0.2
      @new_block = HotelSystem::Block.new(rooms: @rooms, arrive_day: @arrive_day, depart_day: @depart_day, discount: @discount)
    end
    it "Creates an instance of Block" do
      expect(@new_block).must_be_kind_of HotelSystem::Block
    end

    it "has readable instance variables" do
      expect(@new_block.rooms).must_equal []
      expect(@new_block.reservations).must_equal []
      expect(@new_block.depart_day).must_equal @depart_day
      expect(@new_block.arrive_day).must_equal @arrive_day
      expect(@new_block.discount).must_equal @discount
    end

    it "raises an ArgumentError if passed in a nevative discount" do
      expect {
        create_block(2, @arrive_day, @depart_day, -0.5)
      }.must_raise ArgumentError
    end

    it "raises an ArgumentError if passed in a number over 1" do
      expect {
        create_block(2, @arrive_day, @depart_day, 1.1)
      }.must_raise ArgumentError
    end

    it "raises an ArgumentError if started with mroe than 5 rooms" do
      expect {
        create_block(6, @arrive_day, @depart_day, 0.5)
      }.must_raise ArgumentError
    end
  end
  describe "Block check room avalibility" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      @room_two = HotelSystem::Room.new(id: 2)

      reservation = HotelSystem::Reservation.new(
        room: @room,
        arrive_day: Date.parse("2017-05-06"),
        depart_day: Date.parse("2017-05-08"),
      )
      @room.add_reservation(reservation)
    end

    it "raises an Argument Error if any of the rooms are unavalible for any of the days in the range" do
      expect {
        HotelSystem::Block.new(
          rooms: [@room, @room_two],
          arrive_day: Date.parse("2017-05-07"),
          depart_day: Date.parse("2017-05-10"),
          discount: 0,
        )
      }.must_raise ArgumentError
    end

    it "Accepts rooms that have a reservation that ends on the first day of the block" do
      block = HotelSystem::Block.new(
        rooms: [@room, @room_two],
        arrive_day: Date.parse("2017-05-08"),
        depart_day: Date.parse("2017-05-10"),
        discount: 0,
      )
      expect(block).must_be_kind_of HotelSystem::Block
      expect(block.rooms.length).must_equal 2
    end

    it "Accepts rooms that have a reservation the starts on the last day of the block" do
      block = HotelSystem::Block.new(
        rooms: [@room, @room_two],
        arrive_day: Date.parse("2017-05-03"),
        depart_day: Date.parse("2017-05-06"),
        discount: 0,
      )
      expect(block).must_be_kind_of HotelSystem::Block
    end
  end

  describe "Create Block Reservations" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      @room_two = HotelSystem::Room.new(id: 2)
      @room_three = HotelSystem::Room.new(id: 3)
      @arrive_day = Date.parse("2017-05-03")
      @depart_day = Date.parse("2017-05-06")
      @block = HotelSystem::Block.new(
        rooms: [@room, @room_two, @room_three],
        arrive_day: @arrive_day,
        depart_day: @depart_day,
        discount: 0,
      )
    end
    it "Block can call create_block_reservations" do
      expect(@block).must_respond_to :create_block_reservations
    end

    it "Creates a reservation Array containing a reservation for each room in the block, of type BlockReservation" do
      expect(@block.reservations).must_be_kind_of Array
      expect(@block.reservations.first).must_be_kind_of HotelSystem::BlockReservation
    end

    it "adds reservation to the blocks reservation array" do
      expect(@block.reservations.length).must_equal 3
    end

    it "adds each reservation to the corrosponding rooms reservation array" do
      expect(@room.reservations.length).must_equal 1
      expect(@block.reservations).must_include @room.reservations.first
      expect(@room.reservations.first.room.id).must_equal @room.id
    end

    it "creates reservations that have the same start and end day as the block" do
      first_res = @block.reservations.first
      expect(first_res.arrive_day).must_equal @block.arrive_day
      expect(first_res.depart_day).must_equal @block.depart_day
    end
  end
  describe "find_available_reservations" do
    before do
      @number_of_rooms = 3
      @block = create_block(@number_of_rooms, Date.parse("2019-04-27"), Date.parse("2019-05-08"), 0.2)
    end

    it "Can be called on a block" do
      expect(@block).must_respond_to :find_available_reservations
    end

    it "Returns an Array of reservations" do
      available_rooms = @block.find_available_reservations
      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.first).must_be_kind_of HotelSystem::Reservation
      expect(available_rooms.length).must_equal @number_of_rooms
    end
    it "Returns Rooms with :AVAILABLE status in the block reservation" do
      available_reservations = @block.find_available_reservations
      available_reservations.each do |reservation|
        expect(reservation.status).must_equal :AVAILABLE
      end
    end

    it "does not return reservations that have :UNAVAILABLE status" do
      first_res = @block.reservations.first
      @block.book_block_reservation(first_res)
      available_rooms = @block.find_available_reservations
      expect(first_res.status).must_equal :UNAVAILABLE
      expect(available_rooms).wont_include first_res
    end

    it "returns an empty array if no block reservations are available" do
      @block.reservations.each do |res|
        @block.book_block_reservation(res)
      end
      expect(@block.find_available_reservations).must_equal []
    end
  end

  describe "Book Block Reservation" do
    before do
      @number_of_rooms = 3
      @arrive_day = Date.parse("2019-04-27")
      @depart_day = Date.parse("2019-05-08")
      @block = create_block(@number_of_rooms, @arrive_day, @depart_day, 0.2)
      @block.create_block_reservations
      @reservations = @block.find_available_reservations
    end

    it "Can be called on a block" do
      expect(@block).must_respond_to :book_block_reservation
    end

    it "Will raise an ArgumentError if called with reservation that is :UNAVAILABLE" do
      first_res = @reservations.first
      @block.book_block_reservation(first_res)
      expect(first_res.status).must_equal :UNAVAILABLE
      expect {
        @block.book_block_reservation(first_res)
      }.must_raise ArgumentError
    end

    it "Will raise an ArgumentError if its passed a regular Reservations" do
      reservation = create_reservation(create_room(4), @arrive_day, @depart_day)
      expect {
        @block.book_block_reservation(reservation)
      }.must_raise ArgumentError
    end

    it "Will change the status of the reservation from AVAILABLE to UNAVAILABLE" do
      first_res = @reservations.first
      expect(first_res.status).must_equal :AVAILABLE
      @block.book_block_reservation(first_res)
      expect(first_res.status).must_equal :UNAVAILABLE
    end
  end
end
