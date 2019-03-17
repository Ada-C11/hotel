require_relative "spec_helper"
require "date"
require "awesome_print"

describe "RoomBooker" do
  let(:hotel) { RoomBooker.new(rooms: Room.hotel_rooms) }

  describe "instantiation" do
    it "creates an instance of RoomBooker" do
      expect(hotel).must_be_kind_of RoomBooker
    end

    it "creates a list of all 20 rooms" do
      expect(hotel.rooms).must_be_kind_of Array
    end
    it "creates a list of reservations" do
      expect(hotel.reservations).must_be_kind_of Array
    end
  end

  describe "rooms" do
    it "all items in list are an instance of Room" do
      hotel.rooms.each do |room|
        expect(room).must_be_kind_of Room
      end
    end

    it "records room id correctly" do
      expect(hotel.find_room_id(id: 1).id).must_equal 1
      expect(hotel.find_room_id(id: 19).id).must_equal 19
    end

    it "will return nil for a room id that doesn't exist" do
      expect(hotel.find_room_id(id: 1337)).must_be_nil
    end
  end

  describe "book_reservation" do
    let (:make_a_reservation) { hotel.book_reservation(check_in: "August 1st 2020", check_out: "August 5th 2020") }

    it "can create a new reservation" do
      make_a_reservation
      expect(hotel.reservations[0]).must_be_kind_of Reservation
    end

    it "can add a reservation to list of reservations" do
      make_a_reservation
      expect(hotel.reservations.length).must_equal 1
    end

    it "accurately records reservation id" do
      make_a_reservation
      expect(hotel.reservations[0].id).must_equal 1
    end

    it "can find a reservation by id and return its cost" do
      make_a_reservation
      found = hotel.find_cost(id: 1)

      expect(found).must_equal "800.0"
    end
  end

  describe "find by reservation date" do
    before do
      @second_hotel = RoomBooker.new(rooms: Room.hotel_rooms)
      @first_reservation = @second_hotel.book_reservation(check_in: "September 1st 2023", check_out: "September 5th 2023")
      @second_reservation = @second_hotel.book_reservation(check_in: "September 15th 2023", check_out: "September 8th 2023")
      # @third_reservation = @second_hotel.book_reservation(check_in: "September 21st 2023", check_out: "September 25th 2023")
    end

    it "can look up reservations for a given date" do
      found_res = @second_hotel.date_query(date: "September 4th, 2023")
      expected_res = @second_hotel.reservations[0]

      expect(found_res.length).must_equal 1
      expect(found_res[0]).must_equal expected_res
    end

    it "will return nil if no reservations are made on that date" do
      search = @second_hotel.date_query(date: "March 11th, 2020")
      expect(search).must_be_empty
    end

    it "will not book a reservation with conflicting dates" do
      3.times do
        @second_hotel.book_reservation(check_in: "September 21st 2023", check_out: "September 25th 2023")
      end
      ap @second_hotel.rooms # REMOVE ME BEFORE FINAL SUBMIT
    end
  end

  describe "find_available_room" do
    before do
      incoming_allowed = "March 1st 2021"
      outgoing_allowed = "March 2nd 2021"
      @another_hotel = RoomBooker.new(rooms: Room.hotel_rooms)
      @another_hotel.book_reservation(check_in: incoming_allowed, check_out: outgoing_allowed)
    end

    it "***********************" do
      conflict_in = "06/01/20"
      outgoing_2 = ""

      expect { @another_hotel.book_reservation(check_in: conflict_in, check_out: outgoing_2) }.must_raise ArgumentError
    end

    it "will return false for a conflicting booking" do
      # expect(bad_room).must_equal false
    end
  end
end
