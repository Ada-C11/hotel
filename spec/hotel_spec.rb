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
  end

  describe "Reserve room method" do
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

  describe "Find room object that has certain room id" do
    it "returns object associated with room id" do
      expect(@hotel.find_room(0)).must_be_kind_of Hotel::Room
    end

    it "returns the correct room id" do
      expect(@hotel.find_room(0).id).must_equal 0
    end
  end

  describe "Access the list of reservations by date" do
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
      #   p @hotel.reservations
      #   p @hotel.rooms[0].reservations
      p @hotel.access_reservations(Date.new(2001, 3, 6))
    end
  end
end
