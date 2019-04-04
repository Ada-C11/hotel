require 'date'
require 'spec_helper'

describe "Reservation" do
    it "works" do
        expect(true).must_equal true
    end
end

describe "reservation_tracker" do 
    before do 
        @front_desk = Hotel::ReservationTracker.new(19)#num less than 20
    end
    it "it is an instance of a reservation tracker" do
        expect(@front_desk).must_be_kind_of Hotel::ReservationTracker
    end

    it "it raises an error if hotel has more than 20 rooms" do
        expect {hotel = Hotel::ReservationTracker.new(21)}.must_raise ArgumentError
    end

    it "can list the available rooms" do
        expect(@front_desk.all_rooms).must_be_kind_of Array
        expect(@front_desk.all_rooms[2]).must_equal 3
    end

    describe "book reservation method" do
        before do
          @frontdesk = Hotel::ReservationTracker.new(20)
          @frontdesk.book_reservation(1, Date.new(2019,3,15), Date.new(2019,3,18))
        end
    
        it "adds a reservation to the list of reservations" do
          expect(@frontdesk.reservations).must_be_instance_of(Array)
          expect(@frontdesk.reservations[0]).must_be_instance_of(Hotel::Reservation)
        end
    end

    describe "reservation by date method" do
      before do 
        @checkin_date = Date.new(2019,2,3)
        @checkout_date = Date.new(2019,2,5)
        @front_desk = Hotel::ReservationTracker.new(4)
      end
      
      it "allows you to look up a reservation by a specific date" do 
        @front_desk.book_reservation(1, @checkin_date, @checkout_date)
        checking = @front_desk.reservations_by_date(@checkin_date)
        expect(checking[0]).must_be_kind_of Hotel::Reservation
      end # end of this it block
    end # end of this describe block

    describe "check availability method" do
        
        before do 
            @front_desk = Hotel::ReservationTracker.new(3)
            @checkin_date2 = Date.new(2019,3,4)
            @checkout_date2 = Date.new(2019,3,6)
            @reservation2 = @front_desk.book_reservation(3, @checkin_date2, @checkout_date2)

            @checkin_date3 = Date.new(2019,3,4)
            @checkout_date3 = Date.new(2019,3,6)
            @reservation3 = @front_desk.book_reservation(4, @checkin_date3, @checkout_date3)
        end
       
        it "returns rooms that are available" do 
            availability = @front_desk.check_availability(@checkin_date2, @checkout_date2)
            expect(availability).must_kind_of Array
        end
       
        it "book rooms is in array for available rooms" do
            rooms_available = @front_desk.check_availability(@checkin_date2, @checkout_date2)
            expect(rooms_available).length.must_equal 1
            expect(rooms_available).length.wont_equal 2
        end

        it "reservation can starts the day that a different one ends" do
        @checkin_date4 = Date.new(2019,3,6)
        @checkout_date4 = Date.new(2019,3,19)
        @reservation = @front_desk.book_reservation(@checkin_date4, @checkout_date4)
            expect(@reservation).must_be_kind_of Hotel::Reservation
        end

        it "raises an exception when there are no room for the given date" do
            @checkin_date5 = Date.new(2019,3,6)
            @checkout_date5 = Date.new(2019,3,19)
            @reservation = @front_desk.book_reservation(@checkin_date5, @checkout_date5)

            @checkin_date6 = Date.new(2019,3,6)
            @checkout_date6 = Date.new(2019,3,19)

            expect{@front_desk.check_availability(@checkin_date6, @checkout_date6)}.must_raise ArgumentError
        end
    end
end # end of describe block "reservation_tracker"