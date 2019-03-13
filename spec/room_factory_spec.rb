require_relative 'spec_helper.rb'
HOTEL_SIZE = 20
COST = 200.00
describe "Room class" do
  before do
    input = {rm_id: "Room #150", cost: COST}
    @room = Hotel::Room.new(input)
  end

  describe "Room instantiation" do
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end


    it "has good types" do
      expect(@room.rm_id).must_be_kind_of String
      expect(@room.cost).must_be_kind_of Float
    end
  end

  describe "Building a new hotel" do
    before do
      @new_hotel = Hotel::Construction.new
    end

    it "is an instance of Construction" do
      expect(@new_hotel).must_be_kind_of Hotel::Construction
    end
  end
end