require "spec_helper"

describe "Block class" do
  describe "initialize method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @block = HotelSystem::Block.new(date_range: @date_range,
                                      rooms: @hotel.rooms[0...5],
                                      discount_rate: 180)
    end
    it "will create an instance of block" do
      expect(@block).must_be_instance_of HotelSystem::Block
    end
    it "will contain an array of rooms" do
      expect(@block.rooms).must_be_instance_of Array
      @block.rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
    end
    it "will contain a date range " do
      expect(@block.date_range).must_be_instance_of HotelSystem::DateRange
    end
    it "will adjust the rates of each of its rooms" do
      @block.rooms.each do |room|
        expect(room.rate).must_equal(@block.discount_rate)
      end
    end
    it "will adjust the block instance variable of each of its rooms" do
      @block.rooms.each do |room|
        expect(room.block).must_equal(@block)
      end
    end
  end
  describe "reserve from block" do
    before do
      @hotel = HotelSystem::Hotel.new
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @block = HotelSystem::Block.new(date_range: @date_range,
                                      rooms: @hotel.rooms[0...5],
                                      discount_rate: 180)
      @room = @block.rooms[0]
      @block_reservation = @block.reserve()
    end
    it "will return a new reservation for a room within the block" do
      expect(@block_reservation).must_be_instance_of HotelSystem::Reservation
    end
    it "will add the new reservation to the hotel's list of reservations" do
      expect(@hotel.reservations).must_include @block_reservation
    end
    it "will add the reservation to the room's list of reservations" do
      expect(@room.reservations).must_include @block_reservation
    end

    it "will set the reservation's date range equal to the block's date range" do
      expect(@block_reservation.date_range).must_equal @block.date_range
    end

    it "will apply the discount to the total cost of the reservation" do
      expected_cost = @date_range.length * @block.discount_rate
      expect(@block_reservation.total_cost).must_equal expected_cost
    end

    it "will raise an exception if reserving a room that is not within the block" do
      my_room = HotelSystem::Room.new(id: 21, rate: 200)
      expect {
        @block.reserve(my_room)
      }.mustRaise ArgumentError
    end

    it "will raise an exception if reserving a room that is reserved for the date" do
      expect {
        @block.reserve(my_room)
      }.mustRaise ArgumentError
    end
  end
end
