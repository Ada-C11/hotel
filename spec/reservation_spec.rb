require_relative "spec_helper"
require "minitest/skip_dsl"

describe "Reservation" do
  let (:block) { Hotel::Reservation.new(5, "dec 15, 2019", "dec 20, 2019", block_id: 1) }

  describe "Reservation instantiation" do
    it "is an instance of Reservation " do
      trip = Hotel::Reservation.new(1, "dec 15, 2019", "dec 20, 2019")
      expect(trip).must_be_kind_of Hotel::Reservation
    end

    it "raises an argument error if the checkout date is before the check in date" do
      expect { Hotel::Reservation.new(2, "dec 20, 2019", "dec 15, 2019") }.must_raise ArgumentError
    end

    it "initializes status as 'reserved', when making a reservation, or 'blocked' when making a block" do
      trip = Hotel::Reservation.new(1, "dec 15, 2019", "dec 20, 2019")
      expect(trip.status).must_equal "reserved"

      block
      expect(block.status).must_equal "blocked"
    end
  end

  describe "total_cost method" do
    it "Calculates the total cost of the reservation" do
      trip = Hotel::Reservation.new(3, "dec 15, 2019", "dec 20, 2019")
      expect(trip.reservation_cost).must_equal 1000
    end
  end

  describe "reserve_block_rm" do
    it "Reserves a blocked room by changing the status from 'blocked' to 'reserved'" do
      block
      ap block
      expect(block.status).must_equal "blocked"

      block.reserve_block_rm
      ap block
      expect(block.status).must_equal "reserved"
    end
  end
end
