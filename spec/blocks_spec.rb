require_relative "spec_helper"
require "awesome_print"

describe "BlockParty" do
  describe "initialize" do
    blocked_rooms = [1, 2, 3, 4, 5]

    let(:block) { BlockParty.new(check_in: "January 1st 2020", check_out: "January 3rd 2020", blocked_rooms: blocked_rooms, discount: 150) }

    it "can initialize an instance of BlockParty" do
      expect(block).must_be_kind_of BlockParty
    end

    it "contains an array of booked rooms" do
      expect(block.blocked_rooms).must_be_kind_of Array
    end

    it "calculates the total discounted price correctly" do 
      block.total_cost.must_equal 300
    end
  end
end
