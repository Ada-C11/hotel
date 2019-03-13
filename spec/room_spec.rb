require_relative 'spec_helper'

describe "Room class" do 
    before do 
      @room = Room.new(1)
    end
  describe "Room instantiation" do 
    it "is an instance of a room" do 
      expect(@room).must_be_kind_of Room
    end
    it "knows it's id" do 
      expect(@room.id).must_equal 1
    end

    it "knows it's room rate" do 
      expect(@room.price).must_equal 200.00
    end

    it "returns nil for a room that does not exist" do 
      
      expect{Room.new(1337)}.must_raise ArgumentError
    end
  end

  describe "booked_on" do
    before do 
      @room = Room.new(2)
    end
   it "knows what reservations it has" do
    reservation = Reservation.new(id: 1, check_in: "3rd of March", check_out: "5th of March")
     expect(@room).must_respond_to :booked_on 
     expect(@room.booked_on(reservation)).must_be_kind_of Array
   end
  end
end


    

