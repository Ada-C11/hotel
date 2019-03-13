require_relative "spec_helper"

describe "FrontDesk class" do
  let(:frontdesk) { Hotel::FrontDesk.new }
  let(:date1) { "February 3, 2011" }
  let(:date2) { "February 5, 2011" }
  let(:reservation) { frontdesk.reserve(start_date: date1, end_date: date2) }
  let(:start_date) { Date.parse(date1) }
  let(:end_date) { Date.parse(date2) }

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
        frontdesk.reserve(start_date: date2, end_date: date1)
      }.must_raise ArgumentError
    end

    describe "Assign room" do
      it "can assign an available room" do
        fd = Hotel::FrontDesk.new
        res = fd.reserve(start_date: date1, end_date: date2)
        expect(res.room).must_be_kind_of Hotel::Room
        expect(res.room.number).must_equal 1
        res2 = fd.reserve(start_date: date1, end_date: date2) # another reservation on the same nights
        expect(res2.room.number).must_equal 2
      end
    end
  end

  describe "Reservation list" do
    it "adds each new reservation to the list of reservations" do
      expect(frontdesk.reservations).must_be_kind_of Array
      expect(frontdesk.reservations.length).must_equal 0

      frontdesk.reserve(start_date: "February 3, 2011",
                        end_date: "February 5, 2011")

      expect(frontdesk.reservations.length).must_equal 1

      frontdesk.reserve(start_date: "February 4, 2011",
                        end_date: "February 6, 2011")

      expect(frontdesk.reservations.length).must_equal 2
    end

    it "can find a reservation by date" do
      res1 = frontdesk.reserve(start_date: "February 3, 2011",
                               end_date: "February 5, 2011")

      res2 = frontdesk.reserve(start_date: "February 4, 2011",
                               end_date: "February 6, 2011")

      res3 = frontdesk.reserve(start_date: "February 5, 2011",
                               end_date: "February 7, 2011")

      expect(
        frontdesk.find_reservations_by_date(date: "February 3 2011")
      ).must_be_kind_of Array

      expect(
        frontdesk.find_reservations_by_date(date: "February 3 2011").length
      ).must_equal 1

      expect(
        frontdesk.find_reservations_by_date(date: "February 5 2011").length
      ).must_equal 2

      expect(
        frontdesk.find_reservations_by_date(date: "February 3 2011")[0]
      ).must_be_kind_of Hotel::Reservation

      expect(
        frontdesk.find_reservations_by_date(date: "February 5 2011")[0]
      ).must_equal res2
    end
  end

  describe "Open rooms" do
    it "can find open rooms for a date range" do
      open = frontdesk.open_rooms(start_date: date1, end_date: date2)
      expect(open).must_be_kind_of Array
      expect(open.first).must_be_kind_of Hotel::Room
      expect(open.first.available?(date: date2)).must_equal true
    end

    it "doesn't find open rooms when there are none available" do
      jan7 = "january 7, 2019"
      jan8 = "january 8, 2019"
      jan9 = "january 9, 2019"
      jan10 = "january 10, 2019"

      fd = Hotel::FrontDesk.new
      expect(fd.open_rooms(start_date: jan8, end_date: jan9)).must_be_kind_of Array

      20.times do |i|
        res = fd.reserve(start_date: jan7, end_date: jan10)
        expect(res.room.number).must_equal i + 1
      end

      expect { fd.open_rooms(start_date: jan8, end_date: jan9) }.must_raise ArgumentError
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
      days = end_date - start_date + 1
      nights = reservation.nights.length
      expect(days).must_equal 3
      expect(nights).must_equal 2
      expect(days - nights).must_equal 1
      expect(start_date).must_equal reservation.nights.first
      expect(end_date).must_equal Date.new(2011, 2, 5)
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
