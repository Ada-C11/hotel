require 'spec_helper.rb'

describe "Room class" do
  before do
    @room = Hotel::Room.new(
      rm_id: 1,
      cost: COST
    )
  end

  describe "Room instantiation" do
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end


    it "has good types" do

      expect(@room.rm_id).must_be_kind_of Integer
      expect(@room.rate).must_be_kind_of Float
    end
  end
end