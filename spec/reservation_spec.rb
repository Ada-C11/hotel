require_relative "spec_helper"

describe "reservation class" do
  it "returns an instance of class Reservation" do
    res = Reservation.new

    expect(res).must_be_kind_of Reservation
  end
end
