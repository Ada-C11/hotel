require_relative 'spec_helper'

describe "Reservations class" do
reservation_data = {id: 1, start_date: Date.parse("2018-03-20"), end_date: Date.parse("2018-03-27"), room: Hotel::Room.new(1, 200)}
  
  let(:reservation) {Hotel::Reservations.new(reservation_data)}
  
  
  it "is an instance of Reservation" do 
    reservation.must_be_kind_of Hotel::Reservations
  end 

  it "stores instance of room" do
    reservation.room.must_be_kind_of Hotel::Room
  end
  
end
