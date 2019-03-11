require_relative "spec_helper"

describe "reservation class" do
  before do
    @res = Reservation.new(1, Date.new(2019, 3, 10), Date.new(2019, 3, 11))
  end
  it "returns an instance of class Reservation" do
    expect(@res).must_be_kind_of Reservation
  end

  it "finds total price based on number of days in reservation" do
  end
end
