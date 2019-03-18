require "spec_helper"
describe "ReservationTracker" do
  def build_reservation_tracker
    return ReservationTracker.new
  end

  before do
    @tracker = build_reservation_tracker
    @tracker.add_reservation("Jane", 1, "2019-4-11", "2019-4-14")
    @tracker.add_reservation("Matt", 2, "2019-4-11", "2019-4-13")
    @tracker.add_reservation("Ngoc", 3, "2019-12-9", "2019-12-23")
  end
  describe "ReservationTracker#add_reservation" do
    it "return the right number of reservations" do
      res_no = @tracker.reservations.length
      expect(res_no).must_equal 3
    end
    it "raise Argument Error when an unavailable room is reserved for a given day" do
      expect { @tracker.add_reservation("Ngoc", 3, "2019-12-9", "2019-12-23") }.must_raise ArgumentError
    end
    it "allows reversation to start on the same day that another reservation for the same room ends" do
      @tracker.add_reservation("Ngoc", 3, "2019-12-23", "2020-1-1")
      res_no = @tracker.reservations.length
      expect(res_no).must_equal 4
    end
  end

  describe "ReservationTracker#reservations_by_date" do
    it "return the right number of reservations by date" do
      list_of_reservation = @tracker.reservations_by_date("2019-4-11")
      expect(list_of_reservation.length).must_equal 2
    end

    it "return the name on the reservation with the start_date the same as the given date" do
      list_of_reservation = @tracker.reservations_by_date("2019-4-11")
      expect(list_of_reservation[1].name).must_equal "Matt"
    end
  end

  describe "ReservationTracker#list_available_rooms" do
    it "return the correct number of available room(s)" do
      available_rooms = @tracker.list_avail_room("2019-1-12", "2019-1-15")
      expect(available_rooms.length).must_equal 20
    end

    it "return the correct number of available room(s)" do
      available_rooms = @tracker.list_avail_room("2019-4-11", "2019-4-15")
      expect(available_rooms.length).must_equal 18
    end
  end

  describe "ReservationTracker#add_hotelblock" do
    it "raises an exception when user attempts to create a Hotel Block in which at least one of the rooms is unavailable for the given date range" do
      expect { @tracker.add_hotelblock("2019-4-11", "2019-4-15", [1, 5, 6, 7], 170) }.must_raise ArgumentError
    end
  end

  describe "ReservationTracker#available_block_room" do
    it "return the correct available room in a block" do
      new_block = @tracker.add_hotelblock("2019-5-11", "2019-5-15", [1, 5, 6, 7], 170)
      @tracker.add_reservation_for_block(new_block, "Ngoc", 6)
      available_rooms = @tracker.avail_block_room(new_block)
      expect (available_rooms.eql?([1, 5, 7])).must_equal true
    end
  end
end
