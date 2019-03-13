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
    it "can make a new reservation for given dates" do
      hotel = Hotel.new
      start_date = Date.new(2018, 3, 5)
      end_date = start_date + 3
      reservation = hotel.make_reservation(start_date, end_date)
      expect(reservation).must_be_instance_of Reservation
    end
  end
  describe "load_reservation" do
    it "return an array of reservationd that have that date" do
      hotel = Hotel.new
      start_date = Date.new(2018, 3, 5)
      end_date = start_date + 3
      hotel.make_reservation(start_date, end_date)
      start_date = Date.new(2018, 3, 4)
      end_date = start_date + 3
      hotel.make_reservation(start_date, end_date)
      a = hotel.load_reservation(Date.new(2018, 3, 4))
      expect(a.length).must_equal 2
    end
  end
end
