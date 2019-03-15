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

  describe "is_available? method" do
    before do
      reservations = [Hotel::Reservation.new(start_date: "03-04-2019", end_date: "05-04-2019", id: 1, room_id: 1)]
      @room = Hotel::Room.new(id: 1, reservations: reservations)
    end

    it "method returns true for an available date" do
      expect(@room.is_available?("07-11-2019")).must_equal true
    end

    it "method returns false for an unavailable date" do
      expect(@room.is_available?("04-04-2019")).must_equal false
    end
  end
end
