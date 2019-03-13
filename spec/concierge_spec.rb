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
      
      it "correctly numbers each room" do
        expect(@concierge.all_rooms[1].room_number).must_equal 2
      end
  end
  
  
  describe "Reserve room method" do
    before do
      @concierge = Hotel::Concierge.new
    end
    
    it "selects an available room" do
     @reservation = @concierge.reserve_room("2019-01-01", "2019-01-03")
      expect(@reservation.first.room.status).must_equal :AVAILABLE
    end
    
    it "updates the Concierge Reservations array" do
      @res_count = @concierge.reservations.length
      @reservation1 = @concierge.reserve_room("2019-01-01", "2019-01-03")
      expect{(@concierge.reservations.length).must_equal (res_count + 1)}
    end
    
    it "updates the Room's list of reservations" do
      @reservation2 = @concierge.reserve_room("2019-05-01", "2019-05-03")
    end  
  end
 
    
  describe "view Reservations by date method" do
    before do
      @concierge = Hotel::Concierge.new

    res1 = @concierge.reserve_room("2019-01-01", "2019-01-04")
    res2 = @concierge.reserve_room("2019-3-1", "2019-3-2")
    res3 = @concierge.reserve_room("2020-1-10", "2020-1-20")

    end
      it "updates the list of reservations" do
        expect(@concierge.reservations.length).must_equal 3
      end
      
      it "contains instances of reservations" do
        expect(@concierge.reservations[2]).must_be_instance_of Hotel::Reservation
      end
      
      it "can display reservations by date range" do
        expect(@concierge.view_reservations_by_date("2019-3-1").first).must_be_instance_of Hotel::Reservation 
      end
    
      it "returns an array of matching dates" do
        expect(@concierge.view_reservations_by_date("2020-1-20")).must_be_kind_of Array
      end
      
      it "accurately returns all reservations for specified date range" do
        expect(@concierge.view_reservations_by_date("2020-1-20").length).must_equal 3
      end
      
    
  end    
end    
