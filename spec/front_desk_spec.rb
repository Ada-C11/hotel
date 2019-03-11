require_relative "spec_helper"

describe "FrontDesk class" do
  describe "Initialization and more" do
    let(:frontdesk) { Hotel::FrontDesk.new }
    let(:start_date) { Date.new(2001, 2, 3) }
    let(:end_date) { Date.new(2001, 2, 5) }

    it "is able to instantiate" do
      expect(frontdesk).must_be_kind_of Hotel::FrontDesk
    end

    it "can pull up list of rooms" do
      expect(frontdesk.rooms).must_be_kind_of Array

      # Can I set this to be NUMBER_OF_ROOMS constant?
      expect(frontdesk.rooms.length).must_equal 20

      expect(frontdesk.rooms[0]).must_be_kind_of Hotel::Room
    end

    it "can reserve a room for given date range" do
      expect(frontdesk.reserve(start_date, end_date)).must_be_kind_of Hotel::Reservation
    end
  end

  describe "Reservation list" do
    let(:frontdesk) { Hotel::FrontDesk.new }
    let(:start_date) { Date.new(2001, 2, 3) }
    let(:end_date) { Date.new(2001, 2, 5) }
    it "adds a new reservation to the list of reservations" do
      expect(frontdesk.reservations).must_be_kind_of Array
      expect(frontdesk.reservations.length).must_equal 0

      reservation1 = frontdesk.reserve(start_date, end_date)
      expect(frontdesk.reservations.length).must_equal 1

      reservation2 = frontdesk.reserve(start_date + 1, end_date + 1)
      expect(frontdesk.reservations.length).must_equal 2
    end
  end
end
