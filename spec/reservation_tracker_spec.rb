require 'spec_helper'

describe "Reservation" do
    it "works" do
        expect(true).must_equal true
    end
end

describe "reservation_tracker" do 
    # before do 
    
    # end
  
    it "it is an instance of a reservation tracker" do
        @front_desk = Hotel::ReservationTracker.new
        expect(@front_desk).must_be_kind_of Hotel::ReservationTracker
    end
end