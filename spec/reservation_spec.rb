require_relative 'spec_helper.rb'
require 'date'

describe "Reservation" do
  before do
    @date_range = Hotel::DateRange.new(Date.new(2019,3,10), Date.new(2019,3,14))
    @reservation = Hotel::Reservation.new(1, @date_range)
  end
  
  it "should create an instantiation of reservation" do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end 

  describe "total cost" do
    before do
      @new_reservation = Hotel::Reservation.new(1, @date_range)
      @new_resrvation2 = Hotel::Reservation.new(1, @date_range)
    end
    
    it "should return the total cost of the reservation" do
      expect(@new_reservation.total_cost).must_equal(800)
    end

  end

end

