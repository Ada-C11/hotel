require_relative "spec_helper"

describe "Room" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(id: 1)
    end

    it "is an instance of Room" do
      expect(@room).must_be_instance_of Hotel::Room
    end

    it "sets reservations to an empty array if not provided" do
      expect(@room.reservations).must_be_kind_of Array
      expect(@room.reservations.length).must_equal 0
    end

    it "is set up for specific attributes and data types" do
      [:id, :reservations].each do |prop|
        expect(@room).must_respond_to prop
      end

      expect(@room.id).must_be_kind_of Integer
    end
  end

  describe "add_reservations" do
    it "adds reservations" do
      room = Hotel::Room.new(id: 1)
      date1 = Hotel::DateRange.new("03-04-2019", "06-04-2019")
      reservation1 = Hotel::Reservation.new(id: 1, date_range: date1, room: room, price: 200)
      room.add_reservation(reservation1)
      expect(room.reservations.include?(reservation1)).must_equal true
    end
  end

  describe "is_available? method" do
    # There's probably a DRYer way to write these tests, but I'm not sure how

    before do
      date1 = Hotel::DateRange.new("03-04-2019", "06-04-2019")
      date2 = Hotel::DateRange.new("03-05-2019", "06-05-2019")
      date3 = Hotel::DateRange.new("03-06-2019", "06-06-2019")
      @room = Hotel::Room.new(id: 1)

      reservation1 = Hotel::Reservation.new(id: 1, date_range: date1, room: @room)
      reservation2 = Hotel::Reservation.new(id: 2, date_range: date2, room: @room)
      reservation3 = Hotel::Reservation.new(id: 3, date_range: date3, room: @room)

      @room.add_reservation(reservation1)
      @room.add_reservation(reservation2)
      @room.add_reservation(reservation3)
    end

    it "method returns true for an available date ranges" do
      range1 = Hotel::DateRange.new("15-04-2019", "19-04-2019")
      range2 = Hotel::DateRange.new("15-05-2019", "19-05-2019")
      expect(@room.is_available?(range1)).must_equal true
      expect(@room.is_available?(range2)).must_equal true
    end

    it "method returns false for an unavailable date range" do
      range3 = Hotel::DateRange.new("04-04-2019", "06-04-2019")
      expect(@room.is_available?(range3)).must_equal false
    end

    it "shows room as available if there are no reservations" do
      room = Hotel::Room.new(id: 2)
      date1 = Hotel::DateRange.new("03-04-2019", "06-04-2019")
      date2 = Hotel::DateRange.new("03-05-2019", "06-05-2019")
      date3 = Hotel::DateRange.new("03-06-2019", "06-06-2019")
      range1 = Hotel::DateRange.new("15-04-2019", "19-04-2019")
      range2 = Hotel::DateRange.new("15-05-2019", "19-05-2019")
      range3 = Hotel::DateRange.new("04-04-2019", "06-04-2019")
      dates = [date1, date2, date3, range1, range2, range3]

      dates.each do |date|
        expect(room.is_available?(date)).must_equal true
      end
    end
  end
end
