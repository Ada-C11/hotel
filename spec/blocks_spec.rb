require_relative "spec_helper"

describe "BlockParty" do
  describe "initialize" do
    blocked_rooms = [1, 2, 3, 4, 5]

    let(:block) { BlockParty.new(blocked_rooms, Date.parse("January 1st 2020"), Date.parse("January 3rd 2020"), 150) }

    it "can initialize an instance of BlockParty" do
      expect(block).must_be_kind_of BlockParty
    end

    it "contains an array of booked rooms" do
      expect(block.blocked_rooms).must_be_kind_of Array
    end
  end
end
