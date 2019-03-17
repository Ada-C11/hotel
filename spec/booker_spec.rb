require_relative "spec_helper.rb"

describe "Booker" do
  let(:booker) { Hotel::Booker.new }
  let(:manifest) { booker.manifest }
  before do
    room_id = 1
    day1 = Date.parse("march 20, 2020")
    day2 = Date.parse("march 28, 2020")
    @pend_reservation = Hotel::Reservation.new(check_in: day1, check_out: day2)
    @room = manifest.find_room(id: room_id)
    booker.book_room(@pend_reservation, @room)
    @reservation = @room.unavailable_list[-1]
  end
  describe "Booker#initialize" do
    it "is a type of Booker" do
      expect(booker).must_be_instance_of Hotel::Booker
    end

    it "has instance variable of type Manifest" do
      expect(manifest).must_be_instance_of Hotel::Manifest
    end
  end

  describe "Booker#book_room" do
    it "adds reservation to unavailable array to manifest for a given room" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "adds reservation correctly" do
      expect(@reservation.check_in).must_equal Date.new(2020, 03, 20)
      expect(@reservation.check_out).must_equal Date.new(2020, 03, 28)
      expect(@reservation.duration_in_days).must_equal 8
      expect(@reservation.cost).must_equal 1600.0
    end

    it "adds reservation to unavailable array in correct room" do
      expect(@room.unavailable_list.include?(@pend_reservation)).must_equal true
    end

    it "raises exception if room is not available for given date range" do
      expect {
        booker.book_room(Hotel::Reservation.new(check_in: Date.new(2020, 03, 22), check_out: Date.new(2020, 03, 27)), @room)
      }.must_raise RoomNotAvailable
    end
  end

  describe "Booker#calculate_cost_of_booking" do
    it "returns a float" do
      expect(booker.calculate_cost_of_booking(reservation: @pend_reservation, room: @room)).must_be_instance_of Float
    end

    it "calculates the cost of booking correctly" do
      expect(booker.calculate_cost_of_booking(reservation: @pend_reservation, room: @room)).must_equal 1600.0
      pend_reservation = Hotel::Reservation.new(check_in: Time.new.to_date, check_out: Time.new.to_date + 2)
      expect(booker.calculate_cost_of_booking(reservation: pend_reservation, room: @room)).must_equal 400.0
    end
  end

  describe "Booker#get_cost_of_booking" do
    it "returns cost of booking from reservation object" do
      expect(booker.get_cost_of_booking(@reservation)).must_equal 1600.0
    end
  end
end
