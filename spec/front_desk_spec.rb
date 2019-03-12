require_relative "spec_helper"

describe "FrontDesk class" do
  describe "Initialization and more" do
    let(:frontdesk) { Hotel::FrontDesk.new }
    let(:start_date) { "February 3, 2011" }
    let(:end_date) { "February 5, 2011" }
    let(:room) { Hotel::Room.new(2) }

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
    let(:frontdesk) { Hotel::FrontDesk.new }
    let(:start_date) { "February 3, 2011" }
    let(:end_date) { "February 5, 2011" }
    let(:room) { Hotel::Room.new(2) }

    it "can reserve a room for given date range" do
      expect(frontdesk.reserve(start_date, end_date, room)).must_be_kind_of Hotel::Reservation
    end

    it "raises an ArgumentError if date range is invalid" do
      expect { frontdesk.reserve("February 5, 2011", "February 3, 2011", room) }.must_raise ArgumentError
    end
  end

  describe "Reservation list" do
    let(:frontdesk) { Hotel::FrontDesk.new }
    let(:start_date) { "February 3, 2011" }
    let(:end_date) { "February 5, 2011" }
    let(:room) { Hotel::Room.new(2) }

    it "adds each new reservation to the list of reservations" do
      expect(frontdesk.reservations).must_be_kind_of Array
      expect(frontdesk.reservations.length).must_equal 0

      frontdesk.reserve("February 3, 2011", "February 5, 2011")
      expect(frontdesk.reservations.length).must_equal 1

      frontdesk.reserve("February 4, 2011", "February 6, 2011")
      expect(frontdesk.reservations.length).must_equal 2
    end

    it "can find a reservation by date" do
      res1 = frontdesk.reserve(start_date, end_date, room)
      res2 = frontdesk.reserve("February 4, 2011", "February 6, 2011", room)
      res3 = frontdesk.reserve("February 5, 2011", "February 7, 2011", room)

      expect(frontdesk.find_by_date("February 3 2011")).must_be_kind_of Array
      expect(frontdesk.find_by_date("February 3 2011").length).must_equal 1
      expect(frontdesk.find_by_date("February 5 2011").length).must_equal 2
      expect(frontdesk.find_by_date("February 3 2011")[0]).must_be_kind_of Hotel::Reservation
      expect(frontdesk.find_by_date("February 5 2011")[0]).must_equal res2
    end

    it "can find open room" do
      expect(frontdesk.find_open_room).must_be_kind_of Hotel::Room
      expect(frontdesk.find_open_room.available?).must_equal true
      expect(frontdesk.find_open_room.status).must_equal :AVAILABLE

      frontdesk.rooms.each do |room|
        room.status = :UNAVAILABLE
      end
      expect { frontdesk.find_open_room }.must_raise ArgumentError
    end
  end
end
