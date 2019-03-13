require_relative "spec_helper"
require "date"
require "time"

module FrontDesk
  describe "class Reservation" do
    describe "Initiliaze method" do
      before do
        @reservation = Hotel::Reservation.new(
          booking_ref: 1201,
          room_number: 3,
          start_date: Date.new(2019, 3, 19),
          end_date: Date.new(2019, 3, 22),
          total_cost: @total_cost,
        )
      end
      it "creates an instance of Reservation" do
        expect(@reservation).must_be_kind_of Hotel::Reservation
      end
    end

    describe "raise Argument" do
      it "raises an exception" do
        expect {
          (Hotel::Reservation.new(
            booking_ref: 1201,
            room_number: 3,
            start_date: Date.new(2019, 3, 9),
            end_date: Date.today,
            total_cost: @total_cost,
          ))
        }.must_raise ArgumentError
      end
    end
  end
end
