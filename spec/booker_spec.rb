require_relative "spec_helper.rb"

describe "Booker" do
  let(:booker) { Hotel::Booker.new }
  let(:manifest) { booker.manifest }
  before do
    room_id = 1
    day1 = Date.parse("march 20, 2020")
    day2 = Date.parse("march 28, 2020")
    @pend_reservation = Hotel::Reservation.new(check_in: day1, check_out: day2)
    @room = manifest.find_room(room_id)
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
  end

  describe "Booker#cost_of_booking" do
    it "returns a float" do
      expect(booker.cost_of_booking(reservation: @pend_reservation, room: @room)).must_be_instance_of Float
    end

    it "calculates the cost of booking correctly" do
      expect(booker.cost_of_booking(reservation: @pend_reservation, room: @room)).must_equal 1600.0
      pend_reservation = Hotel::Reservation.new(check_in: Time.new.to_date, check_out: Time.new.to_date + 2)
      expect(booker.cost_of_booking(reservation: pend_reservation, room: @room)).must_equal 400.0
    end
  end
end
