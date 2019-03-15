require_relative "spec_helper"
require "date"

describe "RoomBooker" do
  before do
    @hotel = RoomBooker.new
    @hotel.make_reservation(check_in: "March 10 2021", check_out: "March 15th 2021")
    @hotel.make_reservation(check_in: "March 22 2021", check_out: "March 30th 2021")
  end
  let(:res) {
    Reservation.new(check_in: "March 2nd, 2020", check_out: "March 5th, 2020")
  }

  describe "instantiation" do
    it "creates a list of all 20 rooms" do
      expect(@hotel.rooms).must_be_kind_of Array
    end
  end

  describe "rooms" do
 
    it "all items in list are an instance of Room" do
      @hotel.rooms.each do |room|
        expect(room).must_be_kind_of Room
      end
    end

    it "records room id correctly" do
      expect(@hotel.find_room_id(1).id).must_equal 1
      expect(@hotel.find_room_id(19).id).must_equal 19
    end

    it "will return nil for a room id that doesn't exist" do 
      expect(@hotel.find_room_id(1337)).must_be_nil
    end
  end

  describe "make_reservation" do

    it "can add a reservation to list of reservations" do
      expect(@hotel.reservations.length).must_equal 2
    end

    it "accurately records reservation id" do
      expect(@hotel.reservations[0].id).must_equal 1
      expect(@hotel.reservations[1].id).must_equal 2
    end

    it "can find a reservation by id and return its cost" do
      found = @hotel.find_cost(1)

      expect(found).must_equal "1000.0"
    end
  end

  describe "find by reservation date" do

    it "can look up reservations for a given date" do
      found_res = @hotel.date_query("March 14th, 2021")
      expected_res = @hotel.reservations[0]

      expect(found_res.length).must_equal 1
      expect(found_res[0]).must_equal expected_res
    end


    it "will return nil if no reservations are made on that date" do
      search = @hotel.date_query("March 11th, 2020")

      expect(search).must_be_nil
    end
  end

  describe "date range overlap?" do 

    it ""
  end
end
