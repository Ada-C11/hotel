require "spec_helper"
describe "ReservationTracker#add_reservation" do
  def build_reservation_tracker
    return ReservationTracker.new
  end

  before do
    @tracker = build_reservation_tracker
    @tracker.add_reservation("Jane", 2, "2019-4-11", "2019-4-14")
    @tracker.add_reservation("Matt", 2, "2019-1-11", "2019-12-11")
    @tracker.add_reservation("Ngoc", 3, "2019-12-9", "2019-12-23")
  end
  it "return the right number of reservations" do
    res_no = @tracker.reservations.length
    expect(res_no).must_equal 3
  end
end
