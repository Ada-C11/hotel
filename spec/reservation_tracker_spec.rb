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
end
