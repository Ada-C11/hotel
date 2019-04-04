require 'date'
require_relative 'spec_helper.rb'

describe "reservation" do 
    before do 
        @checkin_date = Date.new(2019,3,14)
        @checkout_date = Date.new(2019,3,16)
        @reservation = Hotel::Reservation.new(2, @checkin_date, @checkout_date)
    end
    it "it is an instance of a reservation" do
        expect(@reservation).must_be_kind_of Hotel::Reservation
    end
    
    it "raises an error if check before checkin" do
        checkin_date1 = Date.new(2019,3,14) 
        checkout_date2 = Date.new(2019,3,11) 
        expect{Hotel::Reservation.new(3, checkin_date1, checkout_date2)}.must_raise ArgumentError 
    end

    describe "total cost method" do
        before do 
            @checkin_date = Date.new(2019,3,14)
            @checkout_date = Date.new(2019,3,16)
            @reservation = Hotel::Reservation.new(2, @checkin_date, @checkout_date)
        end 
        it "calculates total cost for room booking" do 
            expect(@reservation.total_cost).must_equal 400 #checking for 2 days
        end
    end
end