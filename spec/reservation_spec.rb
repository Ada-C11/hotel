require_relative "spec_helper"

describe "Reservation" do
  describe "instantiation" do
    before do
      @reservation = Hotel::Reservation.new(
        id: 1,
        date_range: Hotel::DateRange.new("03-04-2019", "06-04-2019"),
        room_id: 1,
        room: Hotel::Room.new(id: 1),
      )
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "is set up for specific attributes and data types" do
      [:id, :date_range, :room,
       :room_id, :price].each do |prop|
        expect(@reservation).must_respond_to prop
      end

      expect(@reservation.id).must_be_kind_of Integer
      expect(@reservation.date_range).must_be_instance_of Hotel::DateRange
      expect(@reservation.room).must_be_instance_of Hotel::Room
      expect(@reservation.room_id).must_be_kind_of Integer
      expect(@reservation.price).must_be_kind_of Integer
    end

    it "raises an ArgumentError if room or room id not provided" do
      expect {
        Hotel::Reservation.new(
          id: 1,
          date_range: Hotel::DateRange.new("03-04-2019", "06-04-2019"),
        )
      }.must_raise ArgumentError
    end

    it "accepts room id without room" do
      reservation = Hotel::Reservation.new(
        id: 1,
        date_range: Hotel::DateRange.new("03-04-2019", "06-04-2019"),
        room_id: 1,
      )
      expect(reservation.room).must_equal nil
    end
  end

  describe "total_price method" do
    before do
      @reservation = Hotel::Reservation.new(
        id: 1,
        date_range: Hotel::DateRange.new("03-04-2019", "06-04-2019"),
        room_id: 1,
        room: Hotel::Room.new(id: 1),
      )
    end

    it "calculates the correct price" do
      expect(@reservation.total_price).must_equal 600
    end
  end
end
