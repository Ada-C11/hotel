require_relative 'spec_helper'

describe "Room class" do 
    before do 
      @room = Hotel::Room.new(id: 1, price: 200.00)
    end
  describe "Room instantiation" do 
    it "is an instance of a room" do 
      expect(@room).must_be_kind_of Hotel::Room
    end
  
    it "keeps track of a room id" do 
      expect(@room).must_respond_to :id
      expect(@room.id).must_equal 1
    end

    it "returns nil for a room that does not exist" do 
      expect {
        Hotel::Room.new(id: 1337, price: 200.00)
      }.must_raise ArgumentError
    end

    it "knows that room price is 200" do 
      expect(@room).must_respond_to :price
      expect(@room.price).must_equal 200.00
    end
  end
  describe "all" do 
    it "returns an array of all rooms" do 
      @rooms = Hotel::Room.all

      expect(@rooms).must_be_kind_of Array
    end
  end
end
