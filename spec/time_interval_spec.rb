require 'spec_helper.rb'

describe "time_interval class" do
  describe "initialize" do
    it "returns an instance of time_interval object" do
      check_in = "2019-05-12"
      check_out = "2019-05-16"
      expect(Time_Interval.new(check_in, check_out)).must_be_instance_of Time_Interval
    end

    it "raises an argument error if check in time is after check out time" do
      check_in = "2019/05/12"
      check_out = "2019/05/10"
      expect {
        Time_Interval.new(check_in, check_out)
      }.must_raise ArgumentError
    end

    it "raises an argument error if check in and check out time are in the past" do
      check_in = "2019/02/12"
      check_out = "2019/02/14"
      expect {
        Time_Interval.new(check_in, check_out)
      }.must_raise ArgumentError
    end
  end

  describe "overlap? method" do
    let(:d1) {
      check_in = "2019-12-15"
      check_out = "2019-12-19"
      Time_Interval.new(check_in, check_out)
    }

    let(:d2) {
      check_in = "2019-12-17"
      check_out = "2019-12-20"
      Time_Interval.new(check_in, check_out)
    }

    let(:d3) {
      check_in = "2019-12-15"
      check_out = "2019-12-19"
      Time_Interval.new(check_in, check_out)
    }

    let(:d4) {
      check_in = "2019-12-10"
      check_out = "2019-12-15"
      Time_Interval.new(check_in, check_out)
    }

    it "returns true if two time intervals overlap" do
      expect(Time_Interval.overlap?(d1, d2)).must_equal true
      expect(Time_Interval.overlap?(d3, d4)).must_equal true
    end

    it "returns false if two time intervals do not overlap" do
      expect(Time_Interval.overlap?(d2, d4)).must_equal false
    end
  end
end

