require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Reservation class" do
  before do
    @reservation = Hotel::Reservation.new(check_in: "2019-3-29", check_out: "2019-3-30", room_number: 1)
  end
  it "creates an instance of Reservation" do
    expect(@reservation).must_be_kind_of Hotel::Reservation
  end
end
