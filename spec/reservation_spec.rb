require_relative "spec_helper"

describe "Reservation" do
  before do
    @res = Reservation.new(check_in: Date.new(2005, 2, 2), check_out: Date.new(2005, 2, 4))
  end

  it "is an instance of Reservation" do
    expect(@res).must_be_kind_of Reservation
  end

  it "calculates the right cost" do
    expect(@res.cost).must_equal 400
  end

  it "throw exception with invalid date range" do
    expect do
      Reservation.new(check_in: Date.new(2005, 2, 2), check_out: Date.new(2005, 2, 2))
    end.must_raise ArgumentError
  end
end
