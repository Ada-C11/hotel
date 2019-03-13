require_relative "spec_helper"

describe "FrontDesk class" do
  let(:frontdesk) { Hotel::FrontDesk.new }

  let(:feb3) { "February 3, 2011" }
  let(:feb4) { "February 4, 2011" }
  let(:feb5) { "February 5, 2011" }
  let(:feb6) { "February 6, 2011" }
  let(:feb7) { "February 7, 2011" }
  let(:feb8) { "February 8, 2011" }
  let(:feb9) { "February 9, 2011" }
  let(:feb10) { "February 10, 2011" }

  let(:reservation) { frontdesk.reserve(check_in: feb3, check_out: feb5) }

  describe "Initialization" do
    it "is able to instantiate" do
      expect(frontdesk).must_be_kind_of Hotel::FrontDesk
    end

    it "can generate list of rooms" do
      expect(frontdesk.rooms).must_be_kind_of Array

      # Can I set this to be NUMBER_OF_ROOMS constant?
      expect(frontdesk.rooms.length).must_equal 20

      expect(frontdesk.rooms[0]).must_be_kind_of Hotel::Room
    end

    it "creates an empty array of reservations" do
      expect(frontdesk.reservations).must_be_kind_of Array
      expect(frontdesk.reservations.length).must_equal 0
    end
  end

  describe "Reserve" do
    it "can reserve a room for given date range" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "raises an ArgumentError if date range is invalid" do
      expect {
        frontdesk.reserve(check_in: feb5, check_out: feb3)
      }.must_raise ArgumentError
    end
  end

  describe "Assign room" do
    it "can assign an available room" do
      fd = Hotel::FrontDesk.new
      res = fd.reserve(check_in: feb3, check_out: feb5)
      expect(res.room).must_be_kind_of Hotel::Room
      expect(res.room.number).must_equal 1
      res2 = fd.reserve(check_in: feb3, check_out: feb5) # another reservation on the same nights
      expect(res2.room.number).must_equal 2
    end
  end

  describe "Reservation list" do
    it "adds each new reservation to the list of reservations" do
      expect(frontdesk.reservations).must_be_kind_of Array
      expect(frontdesk.reservations.length).must_equal 0

      frontdesk.reserve(check_in: feb3, check_out: feb5)

      expect(frontdesk.reservations.length).must_equal 1

      frontdesk.reserve(check_in: feb4, check_out: feb6)

      expect(frontdesk.reservations.length).must_equal 2
    end

    it "can find a reservation by date" do
      frontdesk.reserve(check_in: feb3, check_out: feb5)

      res2 = frontdesk.reserve(check_in: feb4, check_out: feb6)

      frontdesk.reserve(check_in: feb5, check_out: feb7)

      expect(
        frontdesk.find_reservations_by_date(date: feb3)
      ).must_be_kind_of Array

      expect(
        frontdesk.find_reservations_by_date(date: feb3).length
      ).must_equal 1

      expect(
        frontdesk.find_reservations_by_date(date: feb5).length
      ).must_equal 2

      expect(
        frontdesk.find_reservations_by_date(date: feb3)[0]
      ).must_be_kind_of Hotel::Reservation

      expect(
        frontdesk.find_reservations_by_date(date: feb5)[0]
      ).must_equal res2
    end
  end

  describe "Open rooms" do
    it "can find open rooms for a date range" do
      open = frontdesk.open_rooms(check_in: feb3, check_out: feb5)
      expect(open).must_be_kind_of Array
      expect(open.first).must_be_kind_of Hotel::Room
      expect(open.first.available?(night: feb5)).must_equal true
      open2 = frontdesk.open_rooms(nights: [Date.new(2011, 1, 2), Date.new(2011, 3, 2)])
      expect(open2).must_be_kind_of Array
      expect(open2.first).must_be_kind_of Hotel::Room
      expect(open2.first.available?(night: Date.new(2011, 3, 2))).must_equal true
    end

    it "raises an ArgumentError if insufficient parameters are given" do
      expect { frontdesk.open_rooms(check_in: feb7) }.must_raise ArgumentError
      expect { frontdesk.open_rooms(check_out: feb9) }.must_raise ArgumentError
      expect { frontdesk.open_rooms() }.must_raise ArgumentError
    end

    it "doesn't find open rooms when there are none available" do
      fd = Hotel::FrontDesk.new
      expect(fd.open_rooms(check_in: feb8, check_out: feb9)).must_be_kind_of Array

      20.times do |i|
        expect(fd.open_rooms(check_in: feb7, check_out: feb10).length).must_equal 20 - i
        res = fd.reserve(check_in: feb7, check_out: feb10)
        expect(res.room.number).must_equal i + 1
      end

      expect { fd.open_rooms(check_in: feb8, check_out: feb9) }.must_raise ArgumentError
    end
  end

  describe "Find by room" do
    it "can find a room based on the room number" do
      room = frontdesk.find_room_by_number(room_number: 7)

      expect(room).must_be_kind_of Hotel::Room
      expect(room.number).must_equal 7
    end

    it "raises an ArgumentError if no rooms are found" do
      expect { frontdesk.find_room_by_number(room_number: 21) }.must_raise ArgumentError
    end
  end

  describe "Generate nights" do
    it "correctly extracts nights needed from days given" do
      check_in_date = Date.parse(feb3)
      check_out_date = Date.parse(feb5)
      days = check_out_date - check_in_date + 1
      nights = reservation.nights.length
      expect(days).must_equal 3
      expect(nights).must_equal 2
      expect(days - nights).must_equal 1
      expect(check_in_date).must_equal reservation.nights.first
      expect(check_out_date).must_equal Date.new(2011, 2, 5)
      expect(reservation.nights.last).must_equal Date.new(2011, 2, 4)
    end
  end

  describe "Rooms array" do
    it "generates an array of rooms" do
      expect(frontdesk.rooms).must_be_kind_of Array
      expect(frontdesk.rooms.length).must_equal 20
      expect(frontdesk.rooms.first).must_be_kind_of Hotel::Room
    end
  end
end
