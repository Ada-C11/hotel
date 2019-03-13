require_relative "spec_helper"

describe "Hotel_manager class" do
  before do
    @hotel_manager = Hotel::HotelManager.new(Hotel::Room.make_rooms_standard)
    @hotel_manager.make_reservation(1, "2019-3-15", "2019-3-20")
    @hotel_manager.make_reservation(2, "2019-3-15", "2019-3-18")
  end

  describe "Hotel_manager instantiation" do
    it "is an istanceof a Hotel_manager" do
      expect(@hotel_manager).must_be_kind_of Hotel::HotelManager
    end

    it "has an array of 20 rooms" do
      expect(@hotel_manager.rooms.length).must_equal 20
    end
  end

  describe "access reservations by date" do
    it "returns an array with the correct number of reservations" do
      reservations = @hotel_manager.list_reservations_by_date("2019-3-15")

      expect(reservations).must_be_kind_of Array
      expect(reservations.length).must_equal 2
    end

    it "doesn't include reservations where the end date is the date" do
      reservations = @hotel_manager.list_reservations_by_date("2019-3-20")

      expect(reservations.length).must_equal 0
    end

    it "includes reservations where the date is between the start and end date" do
      reservations = @hotel_manager.list_reservations_by_date("2019-3-19")

      expect(reservations.length).must_equal 1
    end
  end

  describe "access available rooms" do
    it "returns an array with the available rooms" do
      avail_rooms = @hotel_manager.list_available_rooms("2019-3-15", "2019-3-20")

      expect(avail_rooms).must_be_kind_of Array
      expect(avail_rooms.length).must_equal 18
    end

    it "returns an empty array in there are no rooms" do
      18.times do |i|
        @hotel_manager.make_reservation(i + 3, "2019-3-15", "2019-3-20")
      end
      avail_rooms = @hotel_manager.list_available_rooms("2019-3-15", "2019-3-20")

      expect(avail_rooms.length).must_equal 0
    end
  end

  describe "make reservation" do
    it "makes a reservation and adds to Reservations array if given valid args" do
      before_reservation = @hotel_manager.reservations.length
      @hotel_manager.make_reservation(3, "2019-3-15", "2019-3-20")
      after_reservation = @hotel_manager.reservations.length

      expect(after_reservation - 1).must_equal before_reservation
    end

    it "raises an argument if the room is unavailable during given dates" do
      expect { @hotel_manager.make_reservation(2, "2019-3-15", "2019-3-18") }.must_raise ArgumentError
    end

    it "raises an argument if the dates are not valid" do
      expect { @hotel_manager.make_reservation(3, "2019-3-15", "2019-3-15") }
    end
  end
end
