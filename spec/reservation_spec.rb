require_relative 'spec_helper'
require 'date'
require 'time'

describe "Class named Reservation" do 
  describe "Initialize" do
    before do
      @reservation_1 = Hotel::Reservation.new (
        room_number: 1, 
        start_date = Date.today
        end_date = Date.today + 4,
        cost_per_night: 200.00,
      )
    end

    xit "creates instance of Reservation" do
      expect(@reservation_1).must_be_kind_of Hotel::Reservation
    end
  end
end