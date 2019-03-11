require_relative "spec_helper"

describe "Reservation" do
  let (:my_rez) {
    Reservation.new(reservation_id: 3, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
  }
  it "initializes a reservation when no keyword arguments are given" do
    test_rez = Reservation.new
    # expect(test_rez.room_num).must_be_kind_of NilClass
    expect(test_rez.reservation_id).must_equal 0
    expect(test_rez.check_in_time).must_be_kind_of NilClass
    expect(test_rez.check_out_time).must_be_kind_of NilClass
  end

  describe "duration_of_time" do
    it "must return an integer for duration of time" do
      expect(my_rez.duration_of_stay).must_be_instance_of Integer
    end

    it "must return a positive integer to indicate amount of days" do
      expect(my_rez.duration_of_stay).must_equal 7
    end

    it "must throw an error if integer is negative" do
      bad_rez = Reservation.new(reservation_id: 4, check_in_time: "10th April 2019", check_out_time: "3rd April 2019")
      expect { bad_rez.duration_of_stay }.must_raise ArgumentError
    end
  end

  describe "total_cost" do
    it "returns a valid cost that does not include last day of stay" do
      expect(my_rez.total_cost).must_equal 1200
    end
  end
end
