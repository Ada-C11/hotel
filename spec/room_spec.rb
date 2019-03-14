require 'spec_helper.rb'

describe "Room class" do
  describe "initialize" do
    it "returns an instance of room object" do
      ids = [3, 4, 5]
      ids.each do |id|
        expect(Room.new(id)).must_be_kind_of Room
        expect(Room.new(id).bookings).must_be_kind_of Array
      end
    end
  end

  describe "reserve method" do
    before do
      @room = Room.new(5)
      @duration = Time_Interval.new("2019-08-10", "2019-08-16")
    end

    it "actually adds a new time interval to the room's booking list" do
      num_bookings_before = @room.bookings.length
      @room.reserve(@duration)

      expect(@room.bookings.length).must_equal num_bookings_before + 1
      
      @room.bookings.each do |booking|
        expect(booking).must_be_instance_of Time_Interval
      end
    end
  end
end