require_relative "spec_helper"

describe Hotel do
  describe "initialize" do
    it "should be an instance of the hotel" do
      hotel = Hotel.new
      expect(hotel).must_be_instance_of Hotel
    end
    it "has 20 rooms" do
      hotel = Hotel.new
      expect(hotel.rooms.length).must_equal 20
    end
  end
  describe "load_rooms method" do
    it "gives the list of all the rooms in the hotel" do
      hotel = Hotel.new
      expect(hotel.rooms).must_be_kind_of Array
      expect(hotel.rooms.length).must_equal 20
    end
  end
  describe "add reservation method" do
    # it "adds to the reservation array everytime a new reservation happens" do
    #   start_date = Date.new(2018, 5, 20)
    #   end_date = start_date + 3
    #   id = 8,
    #   room_id = 10,

    #   reservation = Reservation.new(, 3, )
    # end
  end
end
