require_relative "spec_helper"

describe "Block" do
  describe "Block instantiation" do
    it "is an instance of a Block" do
      rooms = Hotel::Room.make_rooms([1, 2, 3, 4, 5])
      block = Hotel::Block.new(rooms, "2019-03-20", "2019-03-27", 175)

      expect(block).must_be_kind_of Hotel::Block
    end

    it "raises an error if more than 5 rooms are given" do
      rooms = Hotel::Room.make_rooms([1, 2, 3, 4, 5, 6])

      expect { Hotel::Block.new(rooms, "2019-03-20", "2019-03-27", 175) }.must_raise ArgumentError
    end
  end
end
