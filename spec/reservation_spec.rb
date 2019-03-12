require_relative "spec_helper"

describe "Reservation class" do
  describe "initialize method" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "08 Feb 2020")
      @new_res = HotelSystem::Reservation.new(date_range: @date_range, room: @new_room, id: 1)
    end
    it "creates an instance of Reservation" do
      expect(@new_res).must_be_instance_of HotelSystem::Reservation
    end
    it "raises an exception if dates are invalid" do
      expect {
        HotelSystem::Reservation.new(
          date_range: HotelSystem::DateRange.new("08 Feb 2020", "01 Feb 2020"),
          room: @new_room,
          id: 1,
        )
      }.must_raise DateRangeError
    end
  end
  describe "reader_methods" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "08 Feb 2020")
      @new_res = HotelSystem::Reservation.new(date_range: @date_range, room: @new_room, id: 1)
    end
    it "can retrieve date_range object" do
      expect(@new_res.date_range).must_be_instance_of HotelSystem::DateRange
    end
    it "can retrieve room object" do
      expect(@new_res.room).must_be_instance_of HotelSystem::Room
    end
  end
  describe "total cost" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "08 Feb 2020")
      @new_res = HotelSystem::Reservation.new(date_range: @date_range, room: @new_room, id: 1)
    end
    it "calculates the total cost of the reservation" do
      expect(@new_res.total_cost).must_equal 1400
    end
  end
end
