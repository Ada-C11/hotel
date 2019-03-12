require_relative "spec_helper"

describe "Reservation_Booker class" do
    before do
        @reservation_booker = Hotel::ReservationBooker.new
    end
   
    it "instantiates ReservationBooker class" do
        expect(@reservation_booker).must_be_kind_of Hotel::ReservationBooker
    end

    it "creates a new instance of reservation" do
       expect(@reservation_booker.create_new_reservation("20190210", "20190212")).must_be_kind_of Hotel::Reservation
    end 

end               