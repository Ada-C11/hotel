require_relative 'spec_helper'
require 'date'

describe "Booking" do 
  before do 
  end

  describe "method for making a reservation" do 
    it "can reserve a room" do 
      reservation = Booking.reservation()
      #returns an instance of a reservation
    end
    it "can reserve multiple rooms" do
    end
    it "can calculate the price of a reservation" do 
    end
  end
end
