require_relative "spec_helper.rb"

describe "Reservation Class" do
  it "Make Reservations" do
    apr4 = Date.new(2019, 4, 3)
    expect(apr4.to_s).must_equal "2019-04-03"
  end
end
