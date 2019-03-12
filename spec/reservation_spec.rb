require_relative 'spec_helper'

describe "Reservation" do
  describe "#initialize" do
    it "Creates an instance of Reservation" do
      reservation = Hotel::Reservation.new("April 1, 2019", "April 5, 2019")
      expect(reservation).must_be_kind_of Hotel::Reservation
    end
  end
end