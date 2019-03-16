require_relative 'spec_helper'

describe "reservation" do
  it 'calculate_total_cost' do
    reservation = Reservation.new(2, Time.parse("2018-07-23"), Time.parse("2018-07-28"))
    expect(reservation.calculate_total_cost).must_equal 1000
  end
end
