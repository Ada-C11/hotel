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

    it "will not book a reservation for a check-in date that occurs after check-out date" do
      expect {
        @second_reservation = @second_hotel.book_reservation(check_in: "September 15th 2023", check_out: "September 8th 2023")
      }.must_raise ArgumentError
    end
  end

  describe "book reservation" do
    before do
      incoming_allowed = "March 4th 2021"
      outgoing_allowed = "March 7th 2021"
      @another_hotel = RoomBooker.new(rooms: Room.hotel_rooms)
      20.times do
        @another_hotel.book_reservation(check_in: incoming_allowed, check_out: outgoing_allowed)
      end
    end

    it "will not double book a room, nor allow invalid booking dates" do
      conflict_1 = "March 4th 2021"
      conflict_2 = "March 6th 2021"
      span_date_in = "March 3rd 2021"
      span_date_out = "March 8th 2021"
      starts_witin_span = "March 5th 2021"
      outside_span = "March 9th 2021"
      starts_before_span = "March 1st 2021"
      finish_in_span = "March 6th 2021"

      pre_check_out = "January 15th 2021"
      ok_checkout = "January 12th 2020"
      bogus = "January 55th 2020"

      expect { @another_hotel.book_reservation(check_in: conflict_1, check_out: conflict_2) }.must_raise ArgumentError
      expect { @another_hotel.book_reservation(check_in: pre_check_out, check_out: ok_checkout) }.must_raise ArgumentError
      expect { @another_hotel.book_reservation(check_in: bogus, check_out: ok_checkout) }.must_raise ArgumentError
      expect { @another_hotel.book_reservation(check_in: span_date_in, check_out: span_date_out) }.must_raise ArgumentError
      expect { @another_hotel.book_reservation(check_in: starts_witin_span, check_out: outside_span) }.must_raise ArgumentError
      expect { @another_hotel.book_reservation(check_in: starts_before_span, check_out: finish_in_span) }.must_raise ArgumentError
    end

    it "will book dates that are adjacent to pre-existing dates" do
      pre_adj = "March 1st 2021"
      aligned = "March 4th 2021"
      @another_hotel.book_reservation(check_in: pre_adj, check_out: aligned)

      expect(@another_hotel.reservations.length).must_equal 21
    end

    it "will book dates that are adjacent to pre-existing dates" do
      post_align = "March 7th 2021"
      post_adj = "March 8th 2021"
      @another_hotel.book_reservation(check_in: post_align, check_out: post_adj)

      expect(@another_hotel.reservations.length).must_equal 21
    end
  end

  describe "get available rooms" do
    before do
      incoming_allowed = "March 2nd 2021"
      outgoing_allowed = "March 6th 2021"
      20.times do
        hotel.book_reservation(check_in: incoming_allowed, check_out: outgoing_allowed)
      end
    end

    it "will find rooms that are available on specific dates" do
      available_rooms = hotel.get_available_rooms(check_in: "March 5th", check_out: "March 6th")

      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.length).must_equal 20
    end

    it "will raise an exception for a date conflict of any kind" do
      going_in = "March 1st 2021"
      conflicts_out = "March 5th 2021"

      expect {
        hotel.get_available_rooms(check_in: going_in, check_out: conflicts_out)
      }.must_raise ArgumentError
    end
  end

  describe "reserve block" do
    let(:block_reservation) { RoomBooker.new(rooms: Room.hotel_rooms) }
    let(:req_date_start) { "January 20th 2020" }
    let(:req_date_end) { "January 23rd 2020" }

    it "raises an exception when trying to book more than 5 rooms" do
      expect {
        block_reservation.reserve_block(check_in: req_date_start, check_out: req_date_end, rooms_needed: 6)
      }.must_raise ArgumentError
    end

    it "can find and book available rooms" do
      successful_block = block_reservation.reserve_block(check_in: req_date_start, check_out: req_date_end, rooms_needed: 3)

      expect(successful_block.blocked_rooms.length).must_equal 3
    end

    # it "will raise an arument error for dates that are unavailable" do
    #   test_reservations = RoomBooker.new(rooms: Room.hotel_rooms)
    #   good_date_in = "March 1st 2021"
    #   good_date_out = "March 4th 2021"
    #   20.times do
    #     test_reservations.book_reservation(check_in: good_date_in, check_out: good_date_out)
    #   end

    #   tester = block_reservation.reserve_block(check_in: good_date_in, check_out: good_date_out, rooms_needed: 3)
    #   expect {
    #     block_reservation.reserve_block(check_in: good_date_in, check_out: good_date_out, rooms_needed: 3)
    #   }.must_raise ArgumentError
    # end
  end
end
