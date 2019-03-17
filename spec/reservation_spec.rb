require_relative "spec_helper"
require "date"

describe "Reservation class" do
  it "lists all reservations" do
    reservations = Hotel::Reservation.all

    reservations.each do |reservation|
      expect(reservation).must_be_kind_of Hotel::Reservation
    end
  end
end
