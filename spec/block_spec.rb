require_relative "spec_helper"

describe "Block" do
  describe "initialize" do
    before do
      @new_block = Hotel::Block.new(
        block_id: 1,
        room_ids: [1, 2, 3],
        check_in_date: "2019-03-10",
        check_out_date: "2019-03-15",
        discount_rate: 0.10,
      )
    end
    it "can be created as an instance of Block class" do
      expect(@new_block).must_be_instance_of Hotel::Block
    end

    it "has attributes of the right data types" do
      expect(@new_block.block_id).must_be_kind_of Integer
      expect(@new_block.room_ids).must_be_kind_of Array
      expect(@new_block.check_in_date).must_be_kind_of Date
      expect(@new_block.check_out_date).must_be_kind_of Date
      expect(@new_block.discount_rate).must_be_kind_of Float
    end
  end
end
