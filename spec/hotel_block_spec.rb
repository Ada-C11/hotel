require_relative "spec_helper"

describe "HOTEL BLOCK TESTS" do
  describe "Hotel block class initialization & set up" do
    it "will return an instance of Hotel Block" do
      check_in = "2019-3-15"
      check_out = "2019-3-20"
      block_test = Hotel_Block.new(check_in, check_out, 5)

      expect(block_test).must_be_kind_of Hotel_Block
    end
  end
end
