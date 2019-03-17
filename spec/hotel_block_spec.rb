require_relative "spec_helper"
describe "Block" do
  describe "initialize" do
    before do
      id = 1
      rooms = [1, 2, 3, 4, 5]
      start_date = Date.new(2018, 5, 5)
      end_date = start_date + 5
      @block = Block.new(id, rooms, start_date, end_date)
    end
    it "can creat a block of rooms for a specific date range" do
      expect(@block).must_be_instance_of Block
    end
    it "makes an array of all the dates in the blocks date range" do
      expect(@block.dates).must_be_kind_of Array
      expect(@block.dates.length).must_equal 5
    end
  end
end
