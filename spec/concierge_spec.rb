require_relative 'spec_helper'

describe "Concierge class" do

  describe "Initialize" do
    before do
      @concierge = Hotel::Concierge.new
    end

    it "is an instance of Concierge" do
      expect(@concierge).must_be_kind_of Hotel::Concierge
    end
   
    it "loads a list of all rooms" do
      expect(@concierge.all_rooms).must_be_kind_of Array
    end
  end
  
  
  describe "See all rooms method" do
    before do
      @concierge = Hotel::Concierge.new
    end
    
    it "returns an array containing all hotel rooms" do
      expect(@concierge.all_rooms).must_be_kind_of Array
    end
    
    it "contains instances of Rooms" do
      expect(@concierge.all_rooms[0]).must_be_instance_of Hotel::Room
    end
    
    it "contains 20 rooms" do
      expect(@concierge.all_rooms.count).must_equal 20
    end
  end
  
  
  describe "Reserve room method" do
   before do
      @concierge = Hotel::Concierge.new
    end
    
    it "selects an available room" do
     reservation = @concierge.reserve_room("2019-01-01", "2019-01-03")
      expect(reservation.status).must_equal :AVAILABLE
    end
    
    it "updates the Concierge Reservations array" do
      res_count = @concierge.reservations.length
      reservation1 = @concierge.reserve_room("2019-01-01", "2019-01-03")
      expect{(@concierge.reservations.length).must_equal (res_count + 1)}
    end
    

  
    
    end

end    
