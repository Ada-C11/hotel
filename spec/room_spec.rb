require 'spec_helper.rb'
require 'date'

describe "Room class" do
  describe "initialize" do
    it "returns an instance of Room" do
      expect(Hotel::Room.new(5)).must_be_instance_of Hotel::Room
    end
  end

  describe "get_reservation_on_date method" do
    it "returns an accurate reservations for a specified date" do
      room = Hotel::Room.new(4)
      room.reserve(Hotel::Time_Interval.new(Date.parse("2019-03-25"), Date.parse("2019-03-29")))

      reservations_list = room.get_reservation_on_date(Date.parse("2019-03-26"))
      expect(reservations_list).must_be_instance_of Hotel::Reservation
    end
  end

  describe "is_available method" do
    before do
      @room = Hotel::Room.new(8)
      @room.reserve(Hotel::Time_Interval.new(Date.parse("2019-03-25"), Date.parse("2019-03-29")))
      @room.reserve(Hotel::Time_Interval.new(Date.parse("2019-03-20"), Date.parse("2019-03-23")))
      @room.block_dates(Hotel::Time_Interval.new(Date.parse("2019-04-20"), Date.parse("2019-04-25")))
      @room.block_dates(Hotel::Time_Interval.new(Date.parse("2019-05-01"), Date.parse("2019-05-05")))
    end

    it "returns true when a room is available for a given period" do
      @room.is_available?(Hotel::Time_Interval.new(Date.parse("2019-03-23"), Date.parse("2019-03-24"))).must_equal true
    end

    it "returns false when a room is unavailable for a given period" do
      @room.is_available?(Hotel::Time_Interval.new(Date.parse("2019-03-20"), Date.parse("2019-03-21"))).must_equal false
    end

    it "returns true when a room block is available for a given period" do
      @room.is_available?(Hotel::Time_Interval.new(Date.parse("2019-04-25"), Date.parse("2019-04-30"))).must_equal true
    end

    it "returns false when a room block is unavailable for a given period" do
      @room.is_available?(Hotel::Time_Interval.new(Date.parse("2019-04-20"), Date.parse("2019-04-25"))).must_equal false
    end
  end

  describe "reserve method" do
    before do
      @room = Hotel::Room.new(9)
    end

    it "added a new reservation to the reservations list" do
      @room.reserve(Hotel::Time_Interval.new(Date.parse("2019-04-01"), Date.parse("2019-04-03")))
      expect(@room.get_reservation_on_date(Date.parse("2019-04-01"))).must_be_instance_of Hotel::Reservation
      expect(@room.get_reservation_on_date(Date.parse("2019-04-01")).room_id).must_equal 9
    end

    it "raises an argument error when there is an attempt to add an overlapped reservation" do
      @room.reserve(Hotel::Time_Interval.new(Date.parse("2019-04-01"), Date.parse("2019-04-03")))
      expect {
        @room.reserve(Hotel::Time_Interval.new(Date.parse("2019-04-01"), Date.parse("2019-04-03")))
      }.must_raise ArgumentError
    end
  end

  describe "reserve_block method" do
    let(:room) {
      Hotel::Room.new(10)
    }

    it "throws an exception if there are no blocked dates" do
      reserved_dates = Hotel::Time_Interval.new(Date.parse("2019-10-14"), Date.parse("2019-10-18"))
      expect {
        room.reserve_block(reserved_dates, 180)
      }.must_raise ArgumentError
    end

    it "successfully reserve a block" do
      reserved_dates = Hotel::Time_Interval.new(Date.parse("2019-10-14"), Date.parse("2019-10-18"))
      discount_rate = 180
      room.block_dates(reserved_dates)
      reservation = room.reserve_block(reserved_dates,discount_rate)
      expect(reservation).must_be_instance_of Hotel::Reservation
      expect(reservation.room_id).must_equal 10
    end

    it "removes the reserved dates from the block_intervals list" do
      duration_one = Hotel::Time_Interval.new(Date.parse("2019-10-14"), Date.parse("2019-10-18"))
      duration_two = Hotel::Time_Interval.new(Date.parse("2019-11-14"), Date.parse("2019-11-18"))
      discount_rate = 180
      room.block_dates(duration_one)
      room.block_dates(duration_two)
      room.reserve_block(duration_one,discount_rate)
      expect(room.has_blocked_dates?(duration_one)).must_equal false
    end
  end

  describe "block_dates method" do
    let(:room) {
      Hotel::Room.new(18)
    }

    it "adds a new date range into the block intervals" do
      duration = Hotel::Time_Interval.new(Date.parse("2019-10-14"), Date.parse("2019-10-18"))
      room.block_dates(duration)
      expect(room.has_blocked_dates?(duration)).must_equal true
    end

    it "throws an exception if the reserved dates overlap with the existing blocked out dates" do
      duration = Hotel::Time_Interval.new(Date.parse("2019-10-14"), Date.parse("2019-10-18"))
      room.block_dates(duration)

      expect {
        room.block_dates(duration)
      }.must_raise ArgumentError
    end

    it "throws an exception if dates are unavailable because of non-block reservations" do
      duration = Hotel::Time_Interval.new(Date.parse("2019-10-14"), Date.parse("2019-10-18"))
      room.reserve(duration)

      expect {
        room.block_dates(duration)
      }.must_raise ArgumentError
    end
  end
end