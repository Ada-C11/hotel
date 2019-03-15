require_relative 'spec_helper'
require 'pry'

describe "Reservation class" do
  before do
    @test_reservation = Hotel::Reservation.new(Date.today.to_s, 5)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@test_reservation).must_be_kind_of Hotel::Reservation
    end
  end
end
