require_relative 'spec_helper'

describe "Concierge class" do

  describe "Initialize" do
    before do
      @concierge = Hotel::Concierge.new(all_rooms: [], 
                                        reservations: []
                                      )
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
      @concierge = Hotel::Concierge.new(all_rooms: [], 
                                        reservations: []
                                      )
    end
    
    it "returns a string list of all hotel rooms" do
      expect(@concierge.see_all_rooms).must_be_kind_of String
    end
  end
  
end    
