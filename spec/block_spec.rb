require_relative "spec_helper"

describe "Block class" do
  describe "initialize method" do
    before do
      @rooms = HotelSystem::Room.make_set(amount: 20, rate: 200)
      @hotel = HotelSystem::Hotel.new(@rooms)
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @block = @hotel.make_block(1, 2, 3, start_date: "01 Feb 2020",
                                          end_date: "10 Feb 2020",
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
    it "will raise an exception if block size is greater than 5 or less than 1" do
      expect {
        HotelSystem::Block.new(date_range: @date_range,
                               rooms: @hotel.rooms[0...7],
                               discount_rate: 180,
                               id: :dklj324321)
      }.must_raise BlockError

      expect {
        HotelSystem::Block.new(date_range: @date_range,
                               rooms: [],
                               discount_rate: 180,
                               id: :asdfh4h5k9)
      }.must_raise BlockError
    end
    it "will contain a date range " do
      expect(@block.date_range).must_be_instance_of HotelSystem::DateRange
    end
    it "will apply the discount to reservations made from it" do
      new_res = @hotel.reserve_from_block(block_id: @block.id, room_id: 1)
      expect(new_res.rate).must_equal @block.discount_rate
    end
    it "will add the block to each room's collection of blocks" do
      @block.rooms.each do |room|
        expect(room.all_blocks).must_include(@block)
      end
    end
    it "can check whether it has any rooms available" do
      expect(@block.has_available_rooms?).must_equal true
      (1..3).each do |id|
        @hotel.reserve_from_block(block_id: @block.id, room_id: id)
      end
      expect(@block.has_available_rooms?).must_equal false
    end
    it "can return a list of available rooms" do
      expect(@block.list_available_rooms.length).must_equal 3
      @block.list_available_rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
      (1..3).each do |id|
        @hotel.reserve_from_block(block_id: @block.id, room_id: id)
      end
      expect(@block.list_available_rooms.length).must_equal 0
    end
    it "can return a list of reservations" do
      expect(@block.all_reservations.length).must_equal 0

      (1..3).each do |id|
        @hotel.reserve_from_block(block_id: @block.id, room_id: id)
      end
      expect(@block.all_reservations.length).must_equal 3
      @block.all_reservations.each do |res|
        expect(res).must_be_instance_of HotelSystem::Reservation
      end
    end
  end
end
