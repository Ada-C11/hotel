require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Reservation class" do
  before do
    @reservation = Hotel::Reservation.new
  end
  it "creates an instance of Reservation" do
    expect(@reservation).must_be_kind_of Hotel::Reservation
  end
end
