require 'spec_helper.rb'

describe "Reservation class" do
  before do
    check_in = "2019/09/17"
    check_out = "2019/09/20"
    duration = Time_Interval.new(check_in, check_out)
    @r = Reservation.new(duration)
  end

  describe "initialize" do
    it "returns an instance of reservation object" do
      expect(@r).must_be_instance_of Reservation
    end
  end

  describe "includes_date method" do
    it "returns true when a specified date falls into the duration of booking" do
      expect(@r.includes_date?("2019-09-18")).must_equal true
    end

    it "returns false when a specified date falls into the duration of booking" do
      expect(@r.includes_date?("2019-09-21")).must_equal false
    end
  end

  describe "get_total_cost method" do
    it "returns a float" do
      expect(@r.get_total_cost).must_be_kind_of Float
    end

    it "returns accurate total costs" do
      expect(@r.get_total_cost).must_be_close_to 600.00
    end
  end
end