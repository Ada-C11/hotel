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
      expect(@hotel.rooms[-1].id).must_equal @new_room.id
      expect(@hotel.rooms[-1]).must_be_kind_of HotelSystem::Room
    end

    it "returns an array listing the number of each room in the hotel" do
      @hotel.rooms << @new_room
      room_list = @hotel.list_rooms
      expect(room_list).must_be_kind_of Array
      expect(room_list[0]).must_equal 1
    end
  end
  describe "hotel reservation" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      room_two = HotelSystem::Room.new(id: 2)
      arrive_day = Date.new(2019, 2, 10)
      depart_day = Date.new(2019, 2, 14)
      @hotel.make_reservation(@room, arrive_day, depart_day)
      @hotel.make_reservation(room_two, arrive_day, depart_day)
      # @reservation = HotelSystem::Reservation.new(room: room, arrive_day: arrive_day, depart_day: depart_day)
    end
    describe "hotel#make_reservation" do
      it "Adds reservation to reservations array" do
        expect(@hotel.reservations.length).must_equal 2
        expect(@hotel.reservations.first).must_be_kind_of HotelSystem::Reservation
      end

      it "Adds reservation to the rooms reservation array" do
        expect(@room.reservations.length).must_equal 1
        expect(@room.reservations.first).must_be_kind_of HotelSystem::Reservation
      end
    end

    describe "#list_reservations" do
      it "returns an array of reservations" do
        reservation_list = @hotel.reservations_by_date(Date.new(2019, 2, 10))
        expect(reservation_list).must_be_kind_of Array
        expect(reservation_list.length).must_equal 2
        expect(reservation_list.first).must_be_kind_of HotelSystem::Reservation
      end

      it "returns an empty array if no reservations are found for that date" do
        reservation_list = @hotel.reservations_by_date(Date.new(2018, 2, 10))
        expect(reservation_list).must_equal []
      end
    end
  end
end
