require_relative "spec_helper"
require "date"

describe "Reservation class" do
  describe "initialize" do
    it "returns an instance of reservation object" do
      check_in = Date.parse("2019/09/17")
      check_out = Date.parse("2019/09/18")
      duration = Hotel::TimeInterval.new(check_in, check_out)
      expect(Hotel::Reservation.new(duration, 1, 1)).must_be_instance_of Hotel::Reservation
    end
  end

  describe "has_date method" do
    before do
      check_in = Date.parse("2019/09/17")
      check_out = Date.parse("2019/09/18")
      duration = Hotel::TimeInterval.new(check_in, check_out)
      @r = Hotel::Reservation.new(duration, 1, 1)
    end

    it "returns true when a specified date falls into the duration of booking" do
      expect(@r.has_date?(Date.parse("2019-09-17"))).must_equal true
    end

    it "returns false when a specified date does not into the duration of booking" do
      expect(@r.has_date?(Date.parse("2019-09-21"))).must_equal false
    end
  end

  describe "get_total_cost method" do
    it "returns accurate total costs for a single room booked for 3 nights" do
      check_in = Date.parse("2019/09/17")
      check_out = Date.parse("2019/09/20")
      duration = Hotel::TimeInterval.new(check_in, check_out)
      r = Hotel::Reservation.new(duration, 1, 200)
      expect(r.total_cost).must_equal 600
    end
  end
end
