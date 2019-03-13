require_relative "spec_helper"
require "date"

describe "HOTEL BLOCK TESTS" do
  describe "Hotel block class initialization & set up" do
    it "will return an instance of Hotel Block" do
      check_in = "2019-3-15"
      check_out = "2019-3-20"
      block_test = Hotel_Block.new(check_in, check_out, 5)

      expect(block_test).must_be_kind_of Hotel_Block
    end
  end

  describe "#date_range" do
    it "returns a range of dates for a hotel block" do
      check_in = "2019-3-15"
      check_out = "2019-3-20"
      date_range = (Date.parse(check_in)...Date.parse("2019-3-20")).to_a
      block_test = Hotel_Block.new(check_in, check_out, 5)

      expect(block_test.date_range(check_in, check_out)).must_equal date_range
    end
  end
end
