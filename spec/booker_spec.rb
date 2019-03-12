require_relative 'spec_helper'
require 'date'

describe "Booking" do 
  before do 
    @booking = Hotel::Booking.new(
      check_in: "March 3rd 2019", 
      check_out: "03-05-2019",
      number_of_rooms: 1)
  end
  describe "initialize" do 
    it "is an instance of a booking" do 
      
      expect(@booking).must_be_kind_of Hotel::Booking
    end

    it "must accurately record check-in date" do 
      expect(@booking).must_respond_to :check_in
      expect(@booking.check_in).must_equal  Chronic.parse("3rd of March 2019")
    end


    it "must accurately record check-out date" do 
      expect(@booking).must_respond_to :check_out
      expect(@booking.check_out).must_equal Chronic.parse("5th of March 2019")
    end

    it "raises an exception for a check-out date that occurs before check-in" do 
      expect {
        Hotel::Booking.new(
          check_in: "March 5th 2019", 
          check_out: "02-05-2019",
          number_of_rooms: 1)
        }.must_raise ArgumentError
    end

    it "raises an exceptions for an invalid check-in day" do 
     expect{ Hotel::Booking.new(
        check_in: "March 100th 2019", 
        check_out: "03-05-2019",
        number_of_rooms: 1)
     }.must_raise ArgumentError
    end

    it "raises an exceptions for an invalid check-out day" do 
      expect{ Hotel::Booking.new(
         check_in: "March 10th 2019", 
         check_out: "03-205-2019",
         number_of_rooms: 1)
      }.must_raise ArgumentError
     end
  end

  describe "method for making a reservation" do 
    it "can reserve a room" do 
    end
    it "can reserve multiple rooms" do
    end
    it "can calculate the price of a reservation" do 
    end
  end
end
