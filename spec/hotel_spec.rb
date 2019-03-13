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
    before do
      hotel.make_reservation(check_in: Date.new(2005, 2, 2), check_out: Date.new(2005, 2, 4))
    end

    it "creates an object nstance of Reservation" do
      expect(hotel.reservations[0]).must_be_kind_of Reservation
      expect(hotel.reservations).must_be_kind_of Array
    end

    it "returns a list of rooms" do
      expect(hotel.list_rooms().length).must_equal 20
    end

    it "it returns reservations by date" do
      hotel.make_reservation(check_in: Date.new(2005, 2, 5), check_out: Date.new(2005, 2, 7))
      hotel.make_reservation(check_in: Date.new(2005, 2, 2), check_out: Date.new(2005, 2, 3))
      expect((hotel.reservation_by_date(Date.new(2005, 2, 3))).length).must_equal 2
    end
  end

  #   it ""

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
