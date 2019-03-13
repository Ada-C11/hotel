require_relative "spec_helper"

describe "Reservation" do
  let (:my_rez) {
    Reservation.new(reservation_id: 3, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
  }
  it "initializes a reservation when no keyword arguments are given" do
    test_rez = Reservation.new
    expect(test_rez.reservation_id).must_equal 0
    expect(test_rez.check_in_time).must_equal Date.today
    expect(test_rez.check_out_time).must_equal (Date.today + 1)
  end

  it "has a room number" do
    expect(my_rez.room_number).must_be_instance_of Integer
  end

  describe "duration_of_stay" do
    it "must return an integer for duration of stay" do
      expect(my_rez.duration_of_stay).must_be_instance_of Integer
    end

    it "must return a positive integer to indicate amount of days" do
      expect(my_rez.duration_of_stay).must_equal 7
    end

    it "must throw an error if date range is invalid" do
      bad_rez = Reservation.new(reservation_id: 4, check_in_time: "10th April 2019", check_out_time: "3rd April 2019")
      expect { bad_rez.duration_of_stay }.must_raise ArgumentError
    end
  end

  describe "calculate_total_cost" do
    it "returns an integer" do
      expect(my_rez.calculate_total_cost).must_be_instance_of Integer
    end
    it "returns a valid cost that does not include last day of stay" do
      expect(my_rez.calculate_total_cost).must_equal 1400
    end
  end

  describe "all rooms" do
    it "has 20 rooms" do
      expect(my_rez.all_rooms.length).must_equal 20
    end
    it "has rooms 1-20 in ascending order" do
      expect(my_rez.all_rooms.first).must_equal 1
      expect(my_rez.all_rooms.last).must_equal 20
    end
  end
end
