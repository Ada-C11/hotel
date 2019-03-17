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
end

describe "book reservation method" do
    before do
        @front_desk = Hotel::ReservationTracker.new(20)
        @front_desk.book_reservation(1, Date.new(2019,3,15), Date.new(2019,3,18))
    end
    it "checking that we are adding reservation to reservations array" do 
        expect(@front_desk.reservations[0]).must_be_instance_of Hotel::Reservation
        expect(@front_desk.reservations).must_be_instance_of Array
    end
end