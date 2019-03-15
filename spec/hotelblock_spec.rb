require_relative "spec_helper"

describe "HotelGroup::HotelBlock class" do
  before do
    @room1 = HotelGroup::Room.new(1, 200)
    @room2 = HotelGroup::Room.new(2, 200)
    @room3 = HotelGroup::Room.new(3, 200)

    @start_time = Date.new(2019, 3, 4)
    @end_time = Date.new(2019, 3, 7)

    @hotel_block = HotelGroup::HotelBlock.new(2, @start_time, @end_time, [@room1, @room2, @room3], 0.2)
  end
  describe "initialize" do
    it "returns a HotelGroup::HotelBlock object" do
      expect(@hotel_block).must_be_instance_of HotelGroup::HotelBlock
    end

    it "returns an error if the number of rooms > 5" do
      expect { HotelGroup::HotelBlock.new(1, @start_time, @end_time, [@room1, @room2, @room3, @room1, @room2, @room3]) }.must_raise ArgumentError
    end
  end

  describe "instance methods" do
    before do
    end

    it "show_unreserved_rooms returns a list of available rooms in the block" do
      expect(@hotel_block.show_unreserved_rooms.count).must_equal 3
    end
  end

  describe "reads from csv" do
    before do
      directory = "spec/test_data"
      @block_list = HotelGroup::HotelBlock.load_all(directory: directory)
    end

    it "reads the records from the file accurately" do
      expect (@block_list.count).must_equal 4
      expect(@block_list.first.id).must_equal 1
    end
  end

  describe "outputs csv file of all blocks" do
    before do
      @hotel = HotelGroup::Hotel.new
    end

    it "creates a csv file" do
      full_path = "spec/test_data/blocks_test.csv"

      HotelGroup::HotelBlock.save(full_path, @hotel.blocks)
    end

    it "adds a block to the CSV file when a new one is created" do
      room = @hotel.rooms[0].number
      block = @hotel.create_hotel_block(Date.new(2016, 8, 8), Date.new(2016, 8, 16), [room], discount: 0.4)

      full_path = "spec/test_data/blocks_test.csv"

      puts @hotel.blocks.count
      HotelGroup::HotelBlock.save(full_path, @hotel.blocks)
    end
  end
end
