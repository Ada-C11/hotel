require_relative "spec_helper"

describe "reservation_booker" do
    before do
        @reservation = Hotel::ReservationBooker.new(check_in_date: 6, check_out_date: 7)
    end
    it "instantiates ReservationBooker class" do
        expect(@reservation).must_be_kind_of Hotel::ReservationBooker
    end

end 