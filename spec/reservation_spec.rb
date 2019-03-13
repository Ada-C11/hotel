require "spec_helper"
require "date"

describe "Reservation class" do
  describe "Initialize" do
    
    it "raises an ArgumentError when the end date is before the start date" do
      expect{ Hotel::Reservation.new(id: 5, room: 9, start_date: "2019-05-10", end_date: "2019-05-09") }.must_raise ArgumentError
    end
    
    it "establishes the base data structures when instantiated" do
      @reservation = Hotel::Reservation.new(
          id: 1, 
          room: 5, 
          start_date:"2019-1-1",
          end_date:"2019-1-10"
          )
        expect(@reservation.id).must_be_kind_of Integer
        expect(@reservation.room).must_be_kind_of Integer
        expect(@reservation.start_date).must_be_kind_of String
    end
    
  end 
  
  
  describe "Total cost method" do
    before do
     @reservation = Hotel::Reservation.new(
          id: 1, 
          room: 5, 
          start_date: "2019-1-1",
          end_date: "2019-1-10"
        )
    end
  
    it "returns an float value" do
      expect(@reservation.total_cost).must_be_kind_of Float
    end
    
    it "accurately calculates the total cost of a reservation" do
      expect(@reservation.total_cost).must_equal 1800.00
    end
  end
  
  
  describe "date range methods" do
    before do
      @reservation = Hotel::Reservation.new(
          id: 10, 
          room: 15, 
          start_date:"January 1, 2019",
          end_date:"2019-01-08"
      )
    end
    
    it "creates an instance of Date class" do
      expect(@reservation.date_range).must_be_instance_of DateRange
    end
    
    it "is comprised of a start and end date" do
      expect(@reservation.date_range.end_date).must_be_instance_of Date
    end
    
    it "correctly transforms the given string date to an instance of Date" do
      @reservation2 = Hotel::Reservation.new(
          id: 11, 
          room: 1, 
          start_date:"20190101", 
          end_date: "02-11-2019"
      )
        expect(@reservation.date_range.start_date).must_equal 
          @reservation2.date_range.start_date
    end
  end
  
end