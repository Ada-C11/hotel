require_relative "spec_helper"

describe "Room class" do
  before do
    @room = Room.new(1)
  end
  describe "Room instantiation" do
    it "is an instance of a room" do
      expect(@room).must_be_kind_of Room
    end
    it "knows it's id" do
      expect(@room.id).must_equal 1
    end

    it "returns nil for a room that does not exist" do
      expect { Room.new(1337) }.must_raise ArgumentError
    end
  end

  describe "booked_on" do
    before do
      @room = Room.new(2)
    end
    it "knows what reservations it has" do
      reservation = Reservation.new(id: 1, check_in: "3rd of March 2020", check_out: "5th of March 2020")
      expect(@room).must_respond_to :booked_on
      expect(@room.booked_on(reservation)).must_be_kind_of Array
    end
  end

  describe "dates overlap?" do
    before do
      checkin = Date.parse("March 9th 2020")
      checkout = Date.parse("March 11th 2020")
      @room.booked_on(checkin...checkout)
    end

    it "allows you to book a room for an incoming date range that ends before any current bookings" do
      start = Date.parse("March 3 2020")
      out = Date.parse("March 6th 2020")

      expect(@room.room_available?(start, out)).must_equal true
    end

    it "allows you to book a room for an incoming date range that starts after any current bookings" do
      start = Date.parse("March 12 2020")
      out = Date.parse("March 14th 2020")
      expect(@room.room_available?(start, out)).must_equal true
    end

    it "allows you to book a room for an incoming checkout date that ends on the same day another reservation begins" do
      start = Date.parse("March 7th 2020")
      out = Date.parse("March 9th 2020")

      expect(@room.room_available?(start, out)).must_equal true
    end

    it "allows you to book a room for an incoming checkout date that ends on the same day another reservation begins" do
      start = Date.parse("March 11th 2020")
      out = Date.parse("March 12th 2020")

      expect(@room.room_available?(start, out)).must_equal true
    end

    it "will not allow a reservation that starts and ends on the same dates as a booking " do 
      start = Date.parse("March 9th 2020")
      out = Date.parse("March 11th 2020")
      
      expect(@room.room_available?(start, out)).must_equal false
    end

    it "will not allow a reservation that occurs within a booked date range" do 
      start = Date.parse("March 10th 2020")
      out = Date.parse("March 11th 2020")

      expect(@room.room_available?(start, out)).must_equal false
    end

    it "it will not allow a reservation that ends during a booked reservation" do 
      start = Date.parse("March 8th 2020")
      out = Date.parse("March 10th 2020")

      expect(@room.room_available?(start, out)).must_equal false
    end

    it " will not allow a reservation that starts during a booked reservation" do 
      start = Date.parse("March 10th 2020")
      out = Date.parse("March 15th 2020")

      expect(@room.room_available?(start, out)).must_equal false
    end
  end

end
