require_relative "spec_helper"

describe "FrontDesk class" do
  let(:frontdesk) { Hotel::FrontDesk.new }
  let(:date1) { "February 3, 2011" }
  let(:date2) { "February 5, 2011" }
  let(:reservation) { frontdesk.reserve(start_date: date1, end_date: date2) }
  let(:start_date) { Date.parse(date1) }
  let(:end_date) { Date.parse(date2) }

  describe "Initialization and more" do
    it "is able to instantiate" do
      expect(frontdesk).must_be_kind_of Hotel::FrontDesk
    end

    it "can pull up list of rooms" do
      expect(frontdesk.rooms).must_be_kind_of Array

      # Can I set this to be NUMBER_OF_ROOMS constant?
      expect(frontdesk.rooms.length).must_equal 20

      expect(frontdesk.rooms[0]).must_be_kind_of Hotel::Room
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
        res2 = fd.reserve(start_date: date1, end_date: date2) # another reservation on the same dates
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
        frontdesk.find_by_date(date: "February 3 2011")
      ).must_be_kind_of Array

      expect(
        frontdesk.find_by_date(date: "February 3 2011").length
      ).must_equal 1

      expect(
        frontdesk.find_by_date(date: "February 5 2011").length
      ).must_equal 2

      expect(
        frontdesk.find_by_date(date: "February 3 2011")[0]
      ).must_be_kind_of Hotel::Reservation

      expect(
        frontdesk.find_by_date(date: "February 5 2011")[0]
      ).must_equal res2
    end

    it "can find open rooms on a date" do
      expect(frontdesk.open_rooms(date: date2)).must_be_kind_of Array
      expect(frontdesk.open_rooms(date: date2).first).must_be_kind_of Hotel::Room
      expect(frontdesk.open_rooms(date: date2).first.available?(date: date2)).must_equal true
    end

    # Currently doesn't work
    it "doesn't find open rooms when there are none available" do
      fd = Hotel::FrontDesk.new
      # expect { fd.open_rooms(date: "january 8, 2019") }.must_be_kind_of Array

      20.times do |i|
        res = fd.reserve(start_date: "january 7, 2019", end_date: "january 10, 2019")
        expect(res.room.number).must_equal i + 1
      end

      expect { fd.open_rooms(date: "january 8, 2019") }.must_raise ArgumentError
    end
  end

  describe "Find by room" do
    it "can find a room based on the room number" do
      room = frontdesk.find_by_room(room_number: 7)

      expect(room).must_be_kind_of Hotel::Room
      expect(room.number).must_equal 7
    end
  end

  describe "Generate dates" do
    it "correctly extracts nights needed from days given" do
      days = end_date - start_date + 1
      nights = reservation.dates.length
      expect(days).must_equal 3
      expect(nights).must_equal 2
      expect(days - nights).must_equal 1
      expect(start_date).must_equal reservation.dates.first
      expect(end_date).must_equal Date.new(2011, 2, 5)
      expect(reservation.dates.last).must_equal Date.new(2011, 2, 4)
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
