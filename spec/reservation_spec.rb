require_relative 'spec_helper'
require 'date'
require 'time'

describe "Class named Reservation" do
  describe "Initialize" do
    before do
      @new_reservation = Hotel::Reservation.new(
        booking_ref: 1,
        room_number: 1,
        start_date: Date.today,
        end_date: Date.today + 3,
        total_cost: @total_cost,
      )
      it "creates an instance of Reservation" do
        expect(@new_reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end
end