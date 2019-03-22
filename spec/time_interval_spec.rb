require "date"
require "spec_helper.rb"

describe "time_interval class" do
  describe "initialize" do
    it "returns an instance of time_interval object" do
      check_in = Date.parse("2019-05-12")
      check_out = Date.parse("2019-05-16")
      expect(Hotel::TimeInterval.new(check_in, check_out)).must_be_instance_of Hotel::TimeInterval
    end

    it "raises an argument error if check in time is after check out time" do
      check_in = Date.parse("2019/05/12")
      check_out = Date.parse("2019/05/10")
      expect {
        Hotel::TimeInterval.new(check_in, check_out)
      }.must_raise ArgumentError
    end

    it "raises an argument error if check in time equals check out time" do
      check_in = Date.parse("2019/05/12")
      check_out = Date.parse("2019/05/12")
      expect {
        Hotel::TimeInterval.new(check_in, check_out)
      }.must_raise ArgumentError
    end
  end

  describe "overlap? method" do
    describe "returns true if two time intervals overlap" do
      # x-------x
      # x-------x
      it "two long identical intervals" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-06-15"), Date.parse("2019-07-15"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-06-15"), Date.parse("2019-07-15"))
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      # x-x
      # x-x
      it "two short identical intervals" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-09-15"), Date.parse("2019-09-16"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-09-15"), Date.parse("2019-09-16"))
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      # x---------x
      #         x-x
      it "one long interval and one short interval with same check_out time" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-09-15"), Date.parse("2019-12-15"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-12-14"), Date.parse("2019-12-15"))
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      # x---------x
      #     x-x
      it "one short interval falls within a long interval" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-09-15"), Date.parse("2019-09-16"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-04-15"), Date.parse("2019-12-15"))
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      # x---------x
      #   x---x
      it "a medium length interval falls within a long interval" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-08-15"), Date.parse("2019-09-15"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-04-15"), Date.parse("2019-12-15"))
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end

      # x---------x
      #      x---------x
      it "two similar length intervals with one's check_in time before the other's check_out time" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-08-15"), Date.parse("2019-08-25"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-08-20"), Date.parse("2019-08-30"))
        expect(i1.overlap?(i2)).must_equal true
        expect(i2.overlap?(i1)).must_equal true
      end
    end

    describe "returns false if two time intervals do not overlap" do

      # x---------x
      #           x---------x
      it "two similar length intervals with one's check_out time equals the other's check_in time" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-08-15"), Date.parse("2019-08-25"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-08-25"), Date.parse("2019-08-30"))
        expect(i1.overlap?(i2)).must_equal false
        expect(i2.overlap?(i1)).must_equal false
      end

      # x---------x
      #           x-x
      it "one long interval with check_out time collides with check_in time of a very short interval" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-08-15"), Date.parse("2019-08-25"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-08-25"), Date.parse("2019-08-26"))
        expect(i1.overlap?(i2)).must_equal false
        expect(i2.overlap?(i1)).must_equal false
      end

      # x---------x
      #              x----------x
      it "two intervals whose boundaries don't collide" do
        i1 = Hotel::TimeInterval.new(Date.parse("2019-08-15"), Date.parse("2019-08-20"))
        i2 = Hotel::TimeInterval.new(Date.parse("2019-08-25"), Date.parse("2019-08-30"))
        expect(i1.overlap?(i2)).must_equal false
        expect(i2.overlap?(i1)).must_equal false
      end
    end
  end

  describe "has_date method" do
    let(:i) {
      Hotel::TimeInterval.new(Date.parse("2019-08-20"), Date.parse("2019-08-25"))
    }

    it "returns true when a given date falls within the time interval" do
      expect(i.has_date?(Date.parse("2019-08-23"))).must_equal true
    end

    it "returns true when a given date is on the check in time" do
      expect(i.has_date?(Date.parse("2019-08-20"))).must_equal true
    end

    it "returns false when a given date is on the check out time" do
      expect(i.has_date?(Date.parse("2019-08-25"))).must_equal false
    end

    it "returns false when a given date does not fall within the time interval" do
      expect(i.has_date?(Date.parse("2019-09-01"))).must_equal false
    end
  end

  describe "equals method" do
    it "returns true when both check_in and check_out date are the same" do
      i1 = Hotel::TimeInterval.new(Date.parse("2019-05-15"), Date.parse("2019-05-20"))
      i2 = Hotel::TimeInterval.new(Date.parse("2019-05-15"), Date.parse("2019-05-20"))
      expect(i1.equals?(i2)).must_equal true
    end

    it "returns false when either check_in or check_out times of two intervals are different" do
      i1 = Hotel::TimeInterval.new(Date.parse("2019-05-15"), Date.parse("2019-05-20"))
      i2 = Hotel::TimeInterval.new(Date.parse("2019-05-10"), Date.parse("2019-05-20"))
      expect(i1.equals?(i2)).must_equal false
    end
  end
end
