require_relative "spec_helper.rb"

describe "Reservation Class" do
  let (:this_res) {
    check_in = Date.new(2019, 06, 03)
    check_out = Date.new(2019, 06, 07)
    this_res = Hotel::Reservation.new(check_in, check_out)
  }
  it "Initialize a Reservation" do
    expect(this_res).must_be_instance_of Hotel::Reservation
  end

  it "Make a reservation for given dates" do
    check_in_date = this_res.ckin_date.to_s
    expect(check_in_date).must_equal "2019-06-03"
  end

  it "Raise argument error if check in date is >= (after or the same as) check out date" do
    check_in = Date.new(2019, 06, 03)
    check_out = Date.new(2019, 06, 03)

    expect { Hotel::Reservation.new(check_in, check_out) }.must_raise ArgumentError
  end

  it "Calculate and store base cost for a reservation" do
    expect(this_res.base_cost).must_equal 800
  end

  # TESTING DATE CONVERSION
  # INSTANCE OF DATE OBJECT TO STRING
  # it "Make Reservations" do
  #   apr4 = Date.new(2019, 4, 3)
  #   expect(apr4.to_s).must_equal "2019-04-03"
  # end

end
