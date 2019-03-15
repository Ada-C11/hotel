require_relative "spec_helper"

describe "class FrontDesk" do
  def build_front_desk
    return Hotel::FrontDesk.new
  end

  describe "all_rooms array" do
    before do
      @rooms = build_front_desk
    end
    # TEST 1
    it "will say all_rooms is an array with a length of 20" do
      expect(@rooms.all_rooms_array).must_be_kind_of Array
      expect(@rooms.all_rooms_array.length).must_equal 20
    end
  end

  describe "make_reservation and add_reservation methods" do
    before do
      @new_reservation = build_front_desk
    end
    # TEST 2
    it "adds reservation to reservations array" do
      reservation_1 = @new_reservation.make_reservation(
        1201,
        1,
        Date.new(2019, 3, 20),
        Date.new(2019, 3, 22),
      )
      # puts "VVVVVVVVVVVVVV"
      # puts "reservation_1: #{reservation_1}"
      # puts "^^^^^^^^^^^^^^"

      @new_reservation.add_reservation(reservation_1)
      expect(@new_reservation.reservations_array.length).must_be :>, 0
      expect(@new_reservation.reservations_array[0].total_cost).must_equal 400
    end
  end

  describe "get reservation by a specific date" do
    before do
      @specific_reservation = build_front_desk
    end
    # TEST 3
    it "will get a reservation by a date" do
      reservation_2 = @specific_reservation.make_reservation(
        1011,
        2,
        Date.new(2019, 4, 8),
        Date.new(2019, 4, 10),
      )
      # puts "VVVVVVVVVVVVVV"
      # puts reservation_2
      # puts "^^^^^^^^^^^^^^"
      @specific_reservation.add_reservation(reservation_2)

      by_date = @specific_reservation.get_reservation_by_date(Date.new(2019, 4, 8), Date.new(2019, 4, 10))

      # puts "BY DATE"
      # puts by_date
      # puts "^^^^^^^^^^^^^^"
      expect(by_date).must_be_kind_of Array
      expect(by_date[0].start_date).must_equal Date.new(2019, 4, 8)
    end
  end

  describe "room_availablity method" do
    before do
      @check_rooms = build_front_desk
    end
    # TEST 4
    it "will return array of available rooms" do
      reservation_3 = @check_rooms.make_reservation(
        1001,
        3,
        Date.new(2019, 4, 8),
        Date.new(2019, 4, 21),
      )
      @check_rooms.add_reservation(reservation_3)

      all_available_rooms = @check_rooms.room_availablity(
        Date.new(2019, 4, 8),
        Date.new(2019, 4, 21)
      )

      expect(all_available_rooms).must_be_kind_of Array
      expect(all_available_rooms.length).must_equal 19
    end
  end

  # TEST 5
  describe "make reservation for a given date range" do
    before do
      @avoid_double_booking = build_front_desk

      @avoid_double_booking.add_reservation(@avoid_double_booking.make_reservation(
        3000,
        3,
        Date.new(2019, 7, 1),
        Date.new(2019, 7, 5)
      ))
    end

    it "will raise an error if a reserved room's dates overlap" do
      expect {
        @avoid_double_booking.make_reservation(
          3001,
          3,
          Date.new(2019, 7, 1),
          Date.new(2019, 7, 5)
        )
      }.must_raise ArgumentError
    end
  end
end
