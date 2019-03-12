require_relative 'spec_helper'

describe "Reservations class" do

  describe "reservations instantiation" do

    it "creates a new reservation" do
      new_reservation = Hotel::Reservations.new
      new_reservation.must_be_kind_of Hotel::Reservations
    end
  end
end