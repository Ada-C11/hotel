require_relative "spec_helper"

describe Hotel do
  before do
    @hotel = Hotel.new
  end
  describe "initialize" do
    it "should be an instance of the hotel" do
      expect(@hotel).must_be_instance_of Hotel
    end
    it "has 20 rooms" do
      expect(@hotel.rooms.length).must_equal 20
    end
  end
  describe "load_rooms method" do
    it "gives the list of all the rooms in the hotel" do
      expect(@hotel.rooms).must_be_kind_of Array
      expect(@hotel.rooms.length).must_equal 20
    end
  end

  describe "add reservation method" do
    it "can make a new reservation for given dates" do
      start_date = Date.new(2018, 3, 5)
      end_date = start_date + 3
      reservation = @hotel.make_reservation(start_date, end_date)
      expect(reservation).must_be_instance_of Reservation
    end
  end
  describe "load_reservation" do
    before do
      start_date1 = Date.new(2018, 3, 5)
      end_date1 = start_date1 + 3
      @hotel.make_reservation(start_date1, end_date1)
      start_date2 = Date.new(2018, 3, 4)
      end_date2 = start_date2 + 4
      @hotel.make_reservation(start_date2, end_date2)
      start_date3 = Date.new(2018, 3, 5)
      end_date3 = start_date3 + 1
      @hotel.make_reservation(start_date3, end_date3)
    end
    it "return an array of reservationd that have that date" do
      reservations = @hotel.load_reservation(Date.new(2018, 3, 4))
      expect(reservations).must_be_kind_of Array
    end
    it "iclude all the reservations that has the date" do
      reservations1 = @hotel.load_reservation(Date.new(2018, 3, 5))
      reservations2 = @hotel.load_reservation(Date.new(2018, 3, 6))
      reservations3 = @hotel.load_reservation(Date.new(2018, 3, 4))
      expect(reservations1.length).must_equal 3
      expect(reservations2.length).must_equal 2
      expect(reservations3.length).must_equal 1
    end
  end
  describe "load availables method" do
    before do
      start_date1 = Date.new(2018, 3, 5)
      end_date1 = start_date1 + 3
      @hotel.make_reservation(start_date1, end_date1)
    end
    it "return an array of all the available rooms" do
      start_date = Date.new(2018, 5, 2)
      end_date = start_date + 3
      #availables1 = load_availables(start_date, end_date)
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 20
      start_date = Date.new(2018, 3, 4)
      end_date = start_date + 3
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 19
    end
  end
end
