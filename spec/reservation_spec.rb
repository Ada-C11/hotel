require_relative "spec_helper"
require "date"
require "time"

module FrontDesk
  describe "class Reservation" do
    describe "Initiliaze method" do
      before do
        @reservation = Hotel::Reservation.new(
          booking_ref: 1201,
          number_of_rooms: 3,
          first_room_number: 10,
          check_in: Date.new(2019, 3, 19),
          check_out: Date.new(2019, 3, 22),
          total_cost: @total_cost,
          room_blocks: @room_blocks,
        )
      end # before
      it "creates an instance of Reservation" do
        expect(@reservation).must_be_kind_of Hotel::Reservation
      end # it

      it "room_blocks is an array" do
        expect(@reservation.room_blocks).must_be_kind_of Array
        expect(@reservation.room_blocks[1]).must_equal 11
      end # it

      it "calculates total cost of a block with discounted rate" do
        expect(@reservation.total_cost).must_equal 1440.0
      end # it
    end # 2nd describe

    describe "raise Argument Errors" do
      it "raises an exception when check_in date is after check_out date" do
        expect {
          (Hotel::Reservation.new(
            booking_ref: 1201,
            number_of_rooms: 3,
            first_room_number: 10,
            check_in: Date.new(2019, 3, 25),
            check_out: Date.new(2019, 3, 22),
            total_cost: @total_cost,
            room_blocks: @room_blocks,
          ))
        }.must_raise ArgumentError
      end # it

      it "raises an exception when check_in date is before the current date" do
        expect {
          (Hotel::Reservation.new(
            booking_ref: 1202,
            number_of_rooms: 4,
            first_room_number: 10,
            check_in: Date.new(2019, 3, 12),
            check_out: Date.today,
            total_cost: @total_cost,
            room_blocks: @room_blocks,
          ))
        }.must_raise ArgumentError
      end # it

      it "raises an exception when number of rooms in a block exceed 5" do
        expect {
          (Hotel::Reservation.new(
            booking_ref: 1203,
            number_of_rooms: 6,
            first_room_number: 10,
            check_in: Date.new(2019, 4, 25),
            check_out: Date.new(2019, 4, 30),
            total_cost: @total_cost,
            room_blocks: @room_blocks,
          ))
        }.must_raise ArgumentError
      end # end

      it "raises an exception when user tries to book a room above 20" do
        expect {
          (Hotel::Reservation.new(
            booking_ref: 1203,
            number_of_rooms: 4,
            first_room_number: 18,
            check_in: Date.new(2019, 4, 25),
            check_out: Date.new(2019, 4, 30),
            total_cost: @total_cost,
            room_blocks: @room_blocks,
          ))
        }.must_raise ArgumentError
      end # end
    end # describe

    describe "Initialize method for single room" do
      before do
        @reservation_2 = Hotel::Reservation.new(
          booking_ref: 1301,
          number_of_rooms: 1,
          first_room_number: 15,
          check_in: Date.new(2019, 5, 20),
          check_out: Date.new(2019, 5, 24),
          total_cost: @total_cost,
          room_blocks: @room_blocks,
        )
      end # before

      it "calculates total cost of single room" do
        expect(@reservation_2.total_cost).must_equal 800.00
      end #it

      it "room_blocks is an array with one element" do
        expect(@reservation_2.room_blocks).must_be_kind_of Array
        expect(@reservation_2.room_blocks[0]).must_equal 15
      end # it
    end # 2nd test for initialize but for single room
  end # 1st describe
end # module
