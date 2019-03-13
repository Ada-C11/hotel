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

    it "raises an argument error if check in time equals check out time" do
      check_in = "2019/05/12"
      check_out = "2019/05/12"
      expect {
        Time_Interval.new(check_in, check_out)
      }.must_raise ArgumentError
    end
  end

  describe "overlap? method" do
    describe "returns true if two time intervals overlap" do
      it "two long identical intervals" do
        i1 = Time_Interval.new("2019-06-15", "2019-07-15")
        i2 = Time_Interval.new("2019-06-15", "2019-07-15")
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      it "two short identical intervals" do
        i1 = Time_Interval.new("2019-09-15", "2019-09-16")
        i2 = Time_Interval.new("2019-09-15", "2019-09-16")
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      it "one very long interval and one short interval with same check_out time" do
        i1 = Time_Interval.new("2019-09-15", "2019-12-15")
        i2 = Time_Interval.new("2019-12-14", "2019-12-15")
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      it "one very short interval falls within a very long interval" do
        i1 = Time_Interval.new("2019-09-15", "2019-09-16")
        i2 = Time_Interval.new("2019-04-15", "2019-12-15")
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      it "a medium length interval falls within a very long interval" do
        i1 = Time_Interval.new("2019-08-15", "2019-09-15")
        i2 = Time_Interval.new("2019-04-15", "2019-12-15")
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      it "two similar length intervals with one's check_in time before the other's check_out time" do
        i1 = Time_Interval.new("2019-08-15", "2019-08-25")
        i2 = Time_Interval.new("2019-08-20", "2019-08-30")
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end
    end

    describe "returns false if two time intervals do not overlap" do
      it "two similar length intervals with one's check_out time equals the other's check_in time" do
        i1 = Time_Interval.new("2019-08-15", "2019-08-25")
        i2 = Time_Interval.new("2019-08-25", "2019-08-30")
        expect(i1.overlap?(i2)).must_equal false
        expect(i2.overlap?(i1)).must_equal false
      end

      it "one very long interval with check_out time collides with check_in time of a very short interval" do
        i1 = Time_Interval.new("2019-08-15", "2019-08-25")
        i2 = Time_Interval.new("2019-08-25", "2019-08-26")
        expect(i1.overlap?(i2)).must_equal false
        expect(i2.overlap?(i1)).must_equal false
      end

      it "two intervals whose boundaries don't collide" do
        i1 = Time_Interval.new("2019-08-15", "2019-08-20")
        i2 = Time_Interval.new("2019-08-25", "2019-08-30")
        expect(i1.overlap?(i2)).must_equal false
        expect(i2.overlap?(i1)).must_equal false
      end
    end
  end
end

