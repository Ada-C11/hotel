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

      @hotel.rooms << @room
      @hotel.rooms << @room_two
      @hotel.rooms << @room_three

      # arrive_day = Date.new(2019, 2, 10)
      # depart_day = Date.new(2019, 2, 14)
      # arrive_day = Date.parse("2019-02-10")
      # depart_day = Date.parse("2019-02-14")
      arrive_day = "2019-02-10"
      depart_day = "2019-02-14"

      @hotel.make_reservation(@room, arrive_day, depart_day)
      @hotel.make_reservation(@room_two, arrive_day, depart_day)
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

    describe "#reservations_by_date" do
      it "returns an array of reservations" do
        # reservation_list = @hotel.reservations_by_date(Date.new(2019, 2, 10))
        reservation_list = @hotel.reservations_by_date("2019-02-10")

        expect(reservation_list).must_be_kind_of Array
        expect(reservation_list.length).must_equal 2
        expect(reservation_list.first).must_be_kind_of HotelSystem::Reservation
      end

      it "returns an empty array if no reservations are found for that date" do
        reservation_list = @hotel.reservations_by_date("2018-02-10")
        expect(reservation_list).must_equal []
      end
    end
    describe "available_rooms_by_date_range" do
      it "Returns an array of Rooms" do
        available_rooms = @hotel.available_rooms_by_date_range("2017-3-15", "2017-3-18")
        expect(available_rooms).must_be_kind_of Array
        expect(available_rooms.first).must_be_kind_of HotelSystem::Room
        expect(available_rooms.length).must_equal 3
      end

      it "Returns rooms that have no conflicting reservations" do
        available_rooms = @hotel.available_rooms_by_date_range("2017-3-15", "2017-3-18")
        expect(available_rooms.length).must_equal 3
      end

      it "Returns rooms that are avaiable, but were occupied the previous night" do
      end

      it "Doesn't return rooms that have conflicting reservations" do
        available_rooms = @hotel.available_rooms_by_date_range("2019-2-12", "2019-2-17")
        expect(available_rooms.length).must_equal 1
      end
    end
  end
end
