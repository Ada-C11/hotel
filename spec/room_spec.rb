require 'spec_helper.rb'
require 'date'

describe "Room class" do
  describe "initialize" do
    it "returns an instance of Room" do
      expect(Room.new(5)).must_be_instance_of Room
    end

    it "includes a list of reservations for each room" do
      expect(Room.new(5).reservations).must_be_instance_of Array
    end
  end

  describe "get_reservations_on_date method" do
    it "returns an accurate list of reservations for a specified date" do
      room = Room.new(4)
      room.reserve(Time_Interval.new(Date.parse("2019-03-25"), Date.parse("2019-03-29")))

      reservations_list = room.get_reservations_on_date(Date.parse("2019-03-26"))
      expect(reservations_list).must_be_instance_of Array
    end
  end

  describe "is_available method" do
    before do
      @room = Room.new(8)
      @room.reserve(Time_Interval.new(Date.parse("2019-03-25"), Date.parse("2019-03-29")))
      @room.reserve(Time_Interval.new(Date.parse("2019-03-20"), Date.parse("2019-03-23")))
    end

    it "returns true when a room is available for a given period" do
      @room.is_available?(Time_Interval.new(Date.parse("2019-03-23"), Date.parse("2019-03-24"))).must_equal true
    end

    it "returns false when a room is unavailable for a given period" do
      @room.is_available?(Time_Interval.new(Date.parse("2019-03-20"), Date.parse("2019-03-21"))).must_equal false
    end
  end

  describe "reserve method" do
    before do
      @room = Room.new(9)
      @room.reserve(Time_Interval.new(Date.parse("2019-03-25"), Date.parse("2019-03-29")))
      @room.reserve(Time_Interval.new(Date.parse("2019-03-20"), Date.parse("2019-03-23")))
      @list_length_before = @room.reservations.length
    end

    it "added a new reservation to the reservations list" do
      @room.reserve(Time_Interval.new(Date.parse("2019-04-01"), Date.parse("2019-04-03")))
      expect(@room.reservations.length).must_equal @list_length_before + 1
    end

    it "raises an argument error when there is an attempt to add an overlapped reservation" do
      expect {
        @room.reserve(Time_Interval.new(Date.parse("2019-03-20"), Date.parse("2019-03-23")))
      }.must_raise ArgumentError
    end
  end
end