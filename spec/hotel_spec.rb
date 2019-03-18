require_relative "spec_helper"

describe "Hotel class" do
  let (:hotel) do
    Hotel.new
  end

  describe "initialize" do
    it "Creates an instance of Hotel" do
      expect(hotel).must_be_instance_of Hotel
    end
  end

  describe "creating a reservation" do
    it "creates an object instance of Reservation" do
      hotel.make_reservation(check_in: Date.new(2005, 2, 2), check_out: Date.new(2005, 2, 4))
      expect(hotel.reservations[0]).must_be_kind_of Reservation
      expect(hotel.reservations).must_be_kind_of Array
    end

    #it throws an argument error if it tries to book something already reserved

    it "returns a list of rooms" do
      expect(hotel.list_rooms().length).must_equal 20
    end

    it "it returns reservations by date" do
      hotel.make_reservation(check_in: Date.new(2005, 2, 2), check_out: Date.new(2005, 2, 4))
      hotel.make_reservation(check_in: Date.new(2005, 2, 5), check_out: Date.new(2005, 2, 7))
      hotel.make_reservation(check_in: Date.new(2005, 2, 2), check_out: Date.new(2005, 2, 4))
      expect((hotel.reservation_by_date(Date.new(2005, 2, 3))).length).must_equal 2
    end

    it "throws argument error if not passed a Date" do
      expect do
        hotel.make_reservation("poop")
      end.must_raise ArgumentError
    end

    it "throws an argument error if you book the same room for the same time" do
      hotel.make_reservation(check_in: Date.new(2005, 2, 5), check_out: Date.new(2005, 2, 7), room: 2)
      expect do
        hotel.make_reservation(check_in: Date.new(2005, 2, 5), check_out: Date.new(2005, 2, 7), room: 2)
      end.must_raise ArgumentError
    end

    it "lets you book a reservation on the same day as a checkout" do
      hotel.make_reservation(check_in: Date.new(2005, 2, 5), check_out: Date.new(2005, 2, 7), room: 2)
      hotel.make_reservation(check_in: Date.new(2005, 2, 7), check_out: Date.new(2005, 2, 9), room: 2)
      expect(hotel.reservations.length).must_equal 2
    end

    it "it wont let you book a reservation on the same day before a checkout" do
      hotel.make_reservation(check_in: Date.new(2005, 2, 5), check_out: Date.new(2005, 2, 7), room: 2)

      expect do
        hotel.make_reservation(check_in: Date.new(2005, 2), check_out: Date.new(2005, 2, 9), room: 2)
      end.must_raise ArgumentError
    end
  end

  describe "reserve/available room method" do
    it "returns an array of available rooms" do
      5.times do
        hotel.reserve_available_room(check_in: Date.new(2005, 2, 3), check_out: Date.new(2005, 2, 9))
      end

      #honestly no idea why this doesn't work, it shows 15 when cutting and pasting in pry
      expect(hotel.available_rooms(check_in: Date.new(2005, 2, 3), check_out: Date.new(2005, 2, 9)).length).must_equal 15
    end

    it "throws an argument error if there is no available room" do
      20.times do
        hotel.reserve_available_room(check_in: Date.new(2005, 2, 6), check_out: Date.new(2005, 2, 8))
      end

      expect do
        hotel.reserve_available_room(check_in: Date.new(2005, 2, 6), check_out: Date.new(2005, 2, 8))
      end.must_raise ArgumentError
    end

    describe "it tests the block reservations" do
      it "throws an argument error if block size is larger than 5" do
        expect do
          hotel.create_hotel_block(check_in: Date.new(2005, 2, 6), check_out: Date.new(2005, 2, 8), block_size: 6)
        end.must_raise ArgumentError
      end

      it "throws an argument error if there aren't enough available rooms for block" do
        16.times do
          hotel.reserve_available_room(check_in: Date.new(2005, 2, 3), check_out: Date.new(2005, 2, 9))
        end
        expect do
          hotel.create_hotel_block(check_in: Date.new(2005, 2, 3), check_out: Date.new(2005, 2, 9), block_size: 5, block_name: "ecc")
        end.must_raise ArgumentError
      end
    end
  end

  #it returns an array of available rooms
  #it throws an argument error if there is no available room

end

#must check that it is available on the last day of the reservation
#must check that it even if check in and check out day are clear, theres not a reservation between them

# Two dates overlap if Date A compared to Date B:
# - Same dates
# - Overlaps in the front
# - Overlaps in the back
# - Completely contained
# - Completely containing

# Two dates are not overlapping if Date A compared to Date B:
# - Completely before
# - Completely after
# - Ends on the checkin date
# - Starts on the checkout date

# return empty array if there are no available rooms
