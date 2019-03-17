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
       
        expect(checking[0]).must_be_kind_of Hotel::ReservationTracker
      end
    end
end