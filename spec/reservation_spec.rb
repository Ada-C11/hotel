require_relative 'spec_helper.rb'
require 'date'

describe "Reservation" do
  before do
    @check_in = Date.new(2019,3,11)
    @check_out = Date.new(2019,3,17)
    @reservation = Hotel::Reservation.new(1, @check_in, @check_out)
  end
  
  it "should create an instantiation of reservation" do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end 
  
  it "Check out date before check in must raise an error" do
    check_in1 = Date.new(2019,3,10)
    check_out2 = Date.new(2019,3,8)
    expect{Hotel::Reservation.new(1, check_in1, check_out2)}.must_raise ArgumentError
  end

  describe "total cost" do
    before do
      @new_reservation = Hotel::Reservation.new(1, @check_in, @check_out)
      @new_resrvation2 = Hotel::Reservation.new(1, @check_in, @check_out)
    end
    
    it "should return the total cost of the reservation" do
      expect(@new_reservation.total_cost).must_equal(1200)
    end

  end

end

