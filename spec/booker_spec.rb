require_relative "spec_helper"

describe "Booker class" do
  describe "initialization" do
    before do
      @booker = Hotel::Booker.new
      @rooms = @booker.rooms
    end

    it "creates an array of all rooms" do
      @rooms.each.with_index(1) do |room, i|
        expect(room).must_be_instance_of Hotel::Room
        expect(room.id).must_equal i
      end
      expect(@rooms).must_be_instance_of Array
      expect(@rooms.count).must_equal 20
    end
  end

  describe "reservation" do
    before do
      @booker = Hotel::Booker.new
      date_range = Hotel::DateRange.new("03-04-2019", "06-04-2019")
      @reservation = @booker.reserve(id: 8, date_range: date_range, room_id: 1)
      @reservations = @booker.reservations
    end

    it "is an instance of reservation" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "reservation is in reservations array" do
      expect(@reservations.include?(@reservation)).must_equal true
    end
  end
end
