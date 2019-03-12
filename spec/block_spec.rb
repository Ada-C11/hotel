require_relative "spec_helper"
describe "Block" do
  describe "initialize" do
    before do
      @rooms = []
      @first_day = Date.parse("2019-01-01")
      @last_day = Date.parse("2019-01-06")
      @discount = 0.2
      @new_block = HotelSystem::Block.new(rooms: @rooms, first_day: @first_day, last_day: @last_day, discount: @discount)
    end
    it "Creates an instance of Block" do
      expect(@new_block).must_be_kind_of HotelSystem::Block
    end

    it "has readable instance variables" do
      expect(@new_block.rooms).must_equal []
      expect(@new_block.reservations).must_equal []
      expect(@new_block.last_day).must_equal @last_day
      expect(@new_block.first_day).must_equal @first_day
      expect(@new_block.discount).must_equal @discount
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
          first_day: Date.parse("2017-05-07"),
          last_day: Date.parse("2017-05-10"),
          discount: 0,
        )
      }.must_raise ArgumentError
    end

    it "Accepts rooms that have a reservation that ends on the first day of the block" do
      block = HotelSystem::Block.new(
        rooms: [@room, @room_two],
        first_day: Date.parse("2017-05-08"),
        last_day: Date.parse("2017-05-10"),
        discount: 0,
      )
      expect(block).must_be_kind_of HotelSystem::Block
      expect(block.rooms.length).must_equal 2
    end

    it "Accepts rooms that have a reservation the starts on the last day of the block" do
      block = HotelSystem::Block.new(
        rooms: [@room, @room_two],
        first_day: Date.parse("2017-05-03"),
        last_day: Date.parse("2017-05-06"),
        discount: 0,
      )
      expect(block).must_be_kind_of HotelSystem::Block
    end
  end

  describe "Create Reservations" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      @room_two = HotelSystem::Room.new(id: 2)
      @roome_three = HotelSystem::Room.new(id: 3)
      @block = HotelSystem::Block.new(
        rooms: [@room, @room_two, @roome_three],
        first_day: Date.parse("2017-05-03"),
        last_day: Date.parse("2017-05-06"),
        discount: 0,
      )
    end
    it "Block can call create_reservations" do
      expect(@block).must_respond_to :create_reservations
    end

    it "Creates a reservation Array containing a reservation for each room in the block, of type BlockReservation" do
      reservations = @block.create_reservations
      expect(reservations.length).must_equal 3
      expect(reservations).must_be_kind_of Array
      expect(reservations.first).must_be_kind_of HotelSystem::BlockReservation
    end

    it "adds reservation to the blocks reservation array" do
      expect(@block.reservations.length).must_equal 0
      reservations = @block.create_reservations
      expect(@block.reservations.length).must_equal 3
    end

    it "adds each reservation to the corrosponding rooms reservation array" do
      expect(@room.reservations.length).must_equal 0
      reservations = @block.create_reservations
      expect(@room.reservations.length).must_equal 1
      expect(reservations).must_include @room.reservations.first
      expect(@room.reservations.first.room.id).must_equal @room.id
    end
  end
end
