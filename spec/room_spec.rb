require_relative "spec_helper"

describe "Room" do
  let(:room) { Hotel::Room.new(id: 3, cost_per_night: 200) }
  describe "Room#initialize" do
    it "creates instance of room" do
      expect(room).must_be_instance_of Hotel::Room
    end

    it "instance variables respond" do
      expect(room).must_respond_to :id
      expect(room).must_respond_to :cost_per_night
      expect(room).must_respond_to :unavailable_list
    end

    it "instance variables are correctly assigned" do
      expect(room.id).must_equal 3
      expect(room.cost_per_night).must_equal 200
      expect(room.unavailable_list).must_equal []
    end
  end

  let(:booker) { Hotel::Booker.new }
  let(:manifest) { booker.manifest }
  before do
    room_id = 1
    @day1 = Date.parse("march 20, 2020")
    @day2 = Date.parse("march 28, 2020")
    @pend_reservation = Hotel::Reservation.new(check_in: @day1, check_out: @day2)
    pend_reservation2 = Hotel::Reservation.new(check_in: @day2 + 3, check_out: @day2 + 6)
    @room = manifest.find_room(id: room_id)
    booker.book(reservation: @pend_reservation, room: @room)
    booker.book(reservation: pend_reservation2, room: @room)
    @reservation = @room.unavailable_list[-1]
  end

  describe "Room#available?" do
    it "returns a boolean" do
      boolean = @room.available?(date: @day1)
      expect(boolean).must_equal !!boolean
    end

    it "returns false if same date as a checkin day" do
      expect(@room.available?(date: @day1)).must_equal false
    end

    it "returns true if same date as a checkout day" do
      expect(@room.available?(date: @day2)).must_equal true
    end

    it "returns false if inbetween a checkin and checkout" do
      expect(@room.available?(date: @day1 + 2)).must_equal false
    end

    it "returns true if date inbetween two unavailable blocks" do
      expect(@room.available?(date: @day2 + 2)).must_equal true
    end

    it "returns true if date is before unavailable dates" do
      expect(@room.available?(date: @day1 - 10)).must_equal true
    end

    it "returns true if date is after unavailable dates" do
      expect(@room.available?(date: @day2 + 10)).must_equal true
    end

    it "returns true if no dates are unavailable" do
      expect(manifest.rooms[2].available?(date: @day1)).must_equal true
    end
  end
  describe "Room#has_unavailable_object?" do
    it "will return true if room has object in unavailable_list" do
      expect(@room.has_unavailable_object?(unavailable_object: @pend_reservation)).must_equal true
    end

    it "will return false if room does not have object in unavailable_list" do
      expect(@room.has_unavailable_object?(unavailable_object: Hotel::Reservation.new(check_in: @day1 + 100, check_out: @day2 + 100)))
    end
  end
end
