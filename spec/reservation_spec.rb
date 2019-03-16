require_relative "spec_helper.rb"

describe "Reservation Class" do
  let (:this_res) {
    check_in = Date.new(2019, 06, 03)
    check_out = Date.new(2019, 06, 07)
    test_res = Hotel::Reservation.new(check_in, check_out)
  }
  it "Initialize a Reservation" do
    expect(this_res).must_be_instance_of Hotel::Reservation
  end

  it "Makes a reservation for given dates" do
    check_in_date = this_res.ckin_date.to_s
    expect(check_in_date).must_equal "2019-06-03"
  end
  # TESTING DATE CONVERSION
  # INSTANCE OF DATE OBJECT TO STRING
  # it "Make Reservations" do
  #   apr4 = Date.new(2019, 4, 3)
  #   expect(apr4.to_s).must_equal "2019-04-03"
  # end
end
