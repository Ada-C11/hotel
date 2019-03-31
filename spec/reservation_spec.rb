require_relative "spec_helper"

describe "Reservation" do
  before do
    @room = HotelSystem::Room.new(id: 1)
    @arrive_day = Date.new(2019, 2, 10)
    @depart_day = Date.new(2019, 2, 14)
    @reservation = HotelSystem::Reservation.new(room: @room, arrive_day: @arrive_day, depart_day: @depart_day)
  end

  describe "initialize" do
    it "Creates a new instance of Reservation" do
      expect(@reservation).must_be_kind_of HotelSystem::Reservation
    end

    it "stores an instance of Room" do
      expect(@reservation.room).must_be_kind_of HotelSystem::Room
    end

    it "Raises an ArgumentError if arrive date is before depart date" do
      expect {
        HotelSystem::Reservation.new(room: @room, arrive_day: @depart_day, depart_day: @arrive_day)
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError if arrive date is the same as depart date" do
      expect {
        HotelSystem::Reservation.new(room: @room, arrive_day: @depart_day, depart_day: @depart_day)
      }.must_raise ArgumentError
    end
  end
  describe "calc_total_cost" do
    before do
      @total_cost = @reservation.calc_total_cost
    end
    it "accuratly adds the total cost for a normal reservation" do
      expect(@total_cost).must_equal 800
    end

    it "Saves total cost to total_cost instance variable" do
      expect(@reservation.total_cost).must_equal 800
    end
  end
end
