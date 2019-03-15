require_relative "spec_helper"

describe "Booker class" do
  describe "initialization" do
    before do
      @booker = Hotel::Booker.new
      @rooms = @booker.rooms
    end

    it "rooms is an array of rooms" do
      @rooms.each.with_index(1) do |room, i|
        expect(room).must_be_instance_of Hotel::Room
        expect(room.id).must_equal i
      end
      expect(@rooms).must_be_instance_of Array
      expect(@rooms.count).must_equal 20
    end
  end

  describe "reserve method" do
    before do
      @booker = Hotel::Booker.new
      @reservation = @booker.reserve(
        id: 1,
        start_date: "03-04-2019",
        end_date: "05-04-2019",
      )
    end

    it "is creates a reservation" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "reservation is in reservations array" do
      expect(@booker.reservations.include?(@reservation)).must_equal true
    end
  end

  describe "available_rooms" do
    before do
      @booker = Hotel::Booker.new
    end

    it "returns an array" do
    end

    it "returns all avaialbe rooms" do
    end
  end
end
