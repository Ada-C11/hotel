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

  describe "make reservation method" do
    before do
      start_date1 = Date.new(2018, 3, 5)
      end_date1 = start_date1 + 3
      @reservation1 = @hotel.make_reservation(start_date1, end_date1)
      start_date2 = Date.new(2018, 3, 5)
      end_date2 = start_date2 + 3
      @reservation2 = @hotel.make_reservation(start_date2, end_date2)
    end
    it "can make a new reservation for given dates" do
      expect(@reservation1).must_be_instance_of Reservation
    end
    it "adds the reservation to the array of reservatios in hotel" do
      expect(@hotel.reservations.length).must_equal 2
    end
    it "adds the reservation to the array of reservation for the room" do
      room = @reservation1.room
      expect(room.reservations.length).must_equal 1
      expect(room.reservations[0]).must_be_instance_of Reservation
      expect(room.reservations[0].id).must_be_kind_of Integer
      expect(room.reservations[0].room.price).must_equal 200
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
      @reservation1 = @hotel.make_reservation(start_date1, end_date1)
      start_date2 = Date.new(2018, 3, 5)
      end_date2 = start_date2 + 3
      @reservation2 = @hotel.make_reservation(start_date2, end_date2)
      start_date3 = Date.new(2018, 3, 5)
      end_date3 = start_date3 + 3
      @reservation3 = @hotel.make_reservation(start_date3, end_date3)
    end
    it "return an array of all the available rooms" do
      start_date = Date.new(2018, 3, 7)
      end_date = start_date + 3
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 20
      start_date = Date.new(2018, 3, 2)
      end_date = start_date + 3
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 20
      start_date = Date.new(2018, 3, 5)
      end_date = start_date + 3
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 17
      start_date = Date.new(2018, 3, 6)
      end_date = start_date + 3
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 17
      start_date = Date.new(2018, 3, 4)
      end_date = start_date + 3
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 17

      start_date = Date.new(2018, 3, 2)
      end_date = start_date + 2
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 20
      start_date = Date.new(2018, 3, 8)
      end_date = start_date + 2
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 20
      start_date = Date.new(2018, 3, 2)
      end_date = start_date + 6
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 17
      start_date = Date.new(2018, 3, 5)
      end_date = start_date + 6
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 17
      start_date = Date.new(2018, 3, 6)
      end_date = start_date + 1
      expect(@hotel.load_availables(start_date, end_date).length).must_equal 17
    end
  end
end
