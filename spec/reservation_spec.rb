require_relative "spec_helper"

describe "Reservation" do
  let (:my_res) {
    Reservation.new(1, reservation_id: 3, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
  }
  describe "initialize method" do
    it "initializes a reservation when no keyword arguments are given" do
      test_rez = Reservation.new(1)
      expect(test_rez.reservation_id).must_equal 0
      expect(test_rez.check_in_time).must_equal Date.today
      expect(test_rez.check_out_time).must_equal (Date.today + 1)
    end

    it "gives a room number" do
      expect(my_res.room_number).must_be_instance_of Integer
    end

    it "should throw an error if room number is over 20" do
      expect { Reservation.new(22) }.must_raise ArgumentError
    end

    it "should throw an error if room number is under 1" do
      expect { Reservation.new(0) }.must_raise ArgumentError
    end

    it "initialize must throw an error if date range is invalid" do
      expect { Reservation.new(2, reservation_id: 4, check_in_time: "10th April 2019", check_out_time: "3rd April 2019") }.must_raise ArgumentError
    end
  end

  describe "calculate_total_cost" do
    it "returns an integer" do
      expect(my_res.calculate_total_cost).must_be_instance_of Integer
    end
    it "returns a valid cost that does not include last day of stay" do
      expect(my_res.calculate_total_cost).must_equal 1400
    end
  end

  describe "all rooms" do
    it "has 20 rooms" do
      expect(my_res.all_rooms.length).must_equal 20
    end
    it "has rooms 1-20 in ascending order" do
      expect(my_res.all_rooms.first).must_equal 1
      expect(my_res.all_rooms.last).must_equal 20
    end
  end
end
