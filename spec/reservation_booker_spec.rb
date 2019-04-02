require_relative "spec_helper"

describe "Reservation_Booker class" do
    before do
        @reservation_booker = Hotel::ReservationBooker.new
    end
   
    it "instantiates ReservationBooker class" do
        expect(@reservation_booker).must_be_kind_of Hotel::ReservationBooker
    end

    it "creates a new instance of reservation" do
       expect(@reservation_booker.create_new_reservation(2019, 02, 10, 2019, 02, 12)).must_be_kind_of Hotel::Reservation
    end  

    it "raises an argument error if given invalid dates" do
        expect {@reservation_booker.create_new_reservation(2019, 02, 10, 2019, 02, 02)}.must_raise ArgumentError
    end

    it "raises an argument error if attempting to reserve an unavailable room" do
        @reservation_booker.create_new_reservation(2019, 02, 10, 2019, 02, 12)
        expect {@reservation_booker.create_new_reservation(2019, 02, 10, 2019, 02, 12)}.must_raise ArgumentError
    end

   describe "list_all_rooms" do

    it "returns an array of room instances" do
        expect(@reservation_booker.list_all_rooms).must_be_instance_of Array
        expect(@reservation_booker.list_all_rooms[2]).must_be_kind_of Hotel::Room
    end
   end

   describe "reservations_by_date" do
    before do
        @reservation_booker.create_new_reservation(2019, 02, 10, 2019, 02, 12)
    end
    
    it "returns an array of reservations" do
        expect(@reservation_booker.reservations_by_date(2019, 02, 10)).must_be_instance_of Array
        # expect(@reservation_booker.reservations_by_date(2019, 02, 10)).must_include 

    end

    it "raises an argument error if given an invalid date" do
        expect {@reservation_booker.reservations_by_date(2019, 14, 23)}.must_raise ArgumentError
    end

   end

   describe "total_cost_by_reservation" do

    it "returns the correct total" do
        @reservation_booker.create_new_reservation(2019, 02, 10, 2019, 02, 12)
        reservation_array = @reservation_booker.reservations_by_date(2019, 02, 10)
        reservation = reservation_array[0]
        expect(@reservation_booker.total_cost_by_reservation(reservation)).must_equal 400

    end
   end

   describe "available_room_by_date_range" do
    before do 
        @reservation_booker.create_new_reservation(2019, 02, 10, 2019, 02, 12)
        reservation_array = @reservation_booker.reservations_by_date(2019, 02, 10)
        reservation = reservation_array[0]
        @room = reservation.room
    end

    it "returns an array of available rooms" do
        expect(@reservation_booker.available_rooms_by_date_range(2019, 02, 10, 2019, 02, 12)).must_be_instance_of Array
        expect(@reservation_booker.available_rooms_by_date_range(2019, 02, 10, 2019, 02, 12)).wont_include @room
    end
   end
end  