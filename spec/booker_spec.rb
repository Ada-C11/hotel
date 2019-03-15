require_relative "spec_helper"
require "date"

describe "RoomBooker" do
  before do
    @hotel = RoomBooker.new
  end
  let(:res) {
    Reservation.new(check_in: "March 2nd, 2020", check_out: "March 5th, 2020")
  }

  describe "instantiation" do
    it "creates a list of all 20 rooms" do
      expect(@hotel.rooms).must_be_kind_of Array
    end
  end

  describe "list_all_rooms" do
    before do
      @hotel = RoomBooker.new
    end
    it "all items in list are an instance of Room" do
      @hotel.rooms.each do |room|
        expect(room).must_be_kind_of Room
      end
    end

    it "records room id correctly" do
      expect(@hotel.rooms[0].id).must_equal 1
    end
  end

  describe "make_reservation" do
    before do
      @hotel = RoomBooker.new
      @hotel.make_reservation(check_in: "March 10 2021", check_out: "March 15th 2021")
      @hotel.make_reservation(check_in: "March 22 2021", check_out: "March 30th 2021")
    end
    it "can add a reservation to list of reservations" do
      expect(@hotel.reservations.length).must_equal 2
    end

    it "accurately records reservation id" do
      expect(@hotel.rooms[0].id).must_equal 1
      expect(@hotel.rooms[1].id).must_equal 2
    end

    it "can find a reservation by id and return its cost" do
      found = @hotel.find_cost(1)
      puts "******************************"
      puts "#{found}"
      expect(found).must_equal "1000.0"
    end
  end

  # describe "find by reservation date" do
  #   before do
  #     # @Hotel.make_reservation(check_in: "March 3rd 2019", check_out: "March 6th 2019")
  #   end
  #   it "can look up all reservations for a given date" do
  #   end

  #   it "will return nil if no reservations are made on that date" do
  #   end
  # end
end
