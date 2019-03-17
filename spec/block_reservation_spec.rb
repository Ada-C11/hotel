require_relative "spec_helper"

describe "BlockReservation" do
  before do
    @room = HotelSystem::Room.new(id: 1)
    @room_two = HotelSystem::Room.new(id: 2)
    @arrive_day = Date.parse("2019-01-01")
    @depart_day = Date.parse("2019-01-06")
    @discount = 0.2
    @new_block = HotelSystem::Block.new(
      rooms: [@room, @room_two],
      first_day: @arrive_day,
      last_day: @depart_day,
      discount: @discount,
    )
  end

  describe "initialize" do
    before do
      @block_reservation = HotelSystem::BlockReservation.new(
        room: @room,
        arrive_day: @arrive_day,
        depart_day: @depart_day,
        block: @new_block,
      )
    end

    it "Creates an instance of BlockReservation" do
      expect(@block_reservation).must_be_kind_of HotelSystem::BlockReservation
    end

    it "Inherits from Reservation" do
      expect(@block_reservation.room).must_equal @room
      expect(@block_reservation.arrive_day).must_equal @arrive_day
      expect(@block_reservation.depart_day).must_equal @depart_day
    end

    it "Saves and can read new instance variables" do
      expect(@block_reservation.block).must_equal @new_block
      expect(@block_reservation.status).must_equal :AVAILABLE
    end
  end
  describe "calc_total_cost" do
    before do
      @block_reservation = HotelSystem::BlockReservation.new(
        room: @room,
        arrive_day: @arrive_day,
        depart_day: @depart_day,
        block: @new_block,
        discount: @discount,
      )

      @total_cost = @block_reservation.calc_total_cost
    end
    it "accuratly adds the total cost for a normal reservation" do
      expect(@total_cost).must_equal 800.0
    end

    it "Saves total cost to total_cost instance variable" do
      expect(@block_reservation.total_cost).must_equal 800.0
    end
  end
end
