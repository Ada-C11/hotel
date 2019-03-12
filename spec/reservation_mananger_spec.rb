require_relative "spec_helper"
describe "RESERVATION MANAGER TESTS" do
  describe "Reservation Manager class initialization & set up" do
    it "will return an instance of Reservation_Manager" do
      test_manager = Reservation_Manager.new
      expect(test_manager).must_be_kind_of Reservation_Manager
    end

    it "can return list of all 20 rooms - Array of Hashes" do
      test_manager = Reservation_Manager.new
      expect(test_manager.all_rooms).must_be_kind_of Array
      expect(test_manager.all_rooms.length).must_equal 20
    end
  end

  describe "#make_reservation in Reservation Manager" do
    it "will contain a collection of Reservation instances" do
      test_manager = Reservation_Manager.new
      # test_reserve = Reservation.new(1, check_in: "2019-3-15", check_out: "2019-3-20")
      check_in = "2019-3-15"
      check_out = "2019-3-20"
      test_manager.make_reservation(check_in, check_out)
      expect(test_manager.all_reservations).must_be_kind_of Array

      test_manager.make_reservation(check_in, check_out)
      expect(test_manager.all_reservations[0]).must_be_kind_of Reservation
    end

    it "returns the correct number of reservations" do
      test_manager = Reservation_Manager.new
      # test_reserve1 = Reservation.new(1, check_in: "2019-3-15", check_out: "2019-3-20")
      # test_reserve2 = Reservation.new(2, check_in: "2019-3-24", check_out: "2019-3-30")
      # test_reserve3 = Reservation.new(2, check_in: "2019-4-4", check_out: "2019-4-6")

      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-24", "2019-3-30")
      test_manager.make_reservation("2019-3-24", "2019-3-30")

      expect(test_manager.all_reservations.length).must_equal 3
    end

    it "adds a random room to the reservation instance" do
      test_manager = Reservation_Manager.new
      # test_reserve1 = Reservation.new(1, check_in: "2019-3-15", check_out: "2019-3-20")
      test_manager.make_reservation("2019-3-15", "2019-3-20")

      expect(test_manager.all_reservations.first.room).must_be_kind_of Hash
      expect(test_manager.all_reservations.first.room["room_id"]).must_be_kind_of Integer
    end

    it "udpates all_reservations and @all_rooms to include one new reservation booked dates" do
      #initialize
      test_manager = Reservation_Manager.new
      # test_reserve1 = Reservation.new(1, check_in: "2019-3-15", check_out: "2019-3-20")

      #set up
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      reservation_check_in = test_manager.all_reservations.last.check_in
      reservation_check_out = test_manager.all_reservations.last.check_out
      date_range = (reservation_check_in...reservation_check_out).to_a
      # room_booked_dates = test_reserve1.room["booked_date"]
      room_booked_dates = test_manager.all_reservations.last.room["booked_date"]

      #TODO: check if we can get rid of one layer of array
      expect(room_booked_dates[0][0]).must_be_kind_of Date

      expect(room_booked_dates.flatten).must_equal date_range
    end

    it "udpates all_reservations and @all_rooms to include multiple new reservation booked dates" do
      #initialize
      test_manager = Reservation_Manager.new
      # test_reserve1 = Reservation.new(1, check_in: "2019-3-15", check_out: "2019-3-20")
      # test_reserve2 = Reservation.new(2, check_in: "2019-3-1", check_out: "2019-3-20")

      #set up
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      reservation1_check_in = test_manager.all_reservations.last.check_in
      reservation1_check_out = test_manager.all_reservations.last.check_out

      test_manager.make_reservation("2019-3-1", "2019-3-20")
      reservation2_check_in = test_manager.all_reservations.last.check_in
      reservation2_check_out = test_manager.all_reservations.last.check_out

      date_range1 = (reservation1_check_in...reservation1_check_out).to_a
      date_range2 = (reservation2_check_in...reservation2_check_out).to_a

      #TODO: check if we can get rid of one layer of array
      expect(test_manager.all_reservations[0].room["booked_date"].flatten).must_equal date_range1
      expect(test_manager.all_reservations[1].room["booked_date"].flatten).must_equal date_range2
    end
  end

  describe "#find_reservation_date" do
    it "will return collection of Reservations made for a specific date range" do
      test_manager = Reservation_Manager.new
      # test_reserve1 = Reservation.new(1, check_in: "2019-3-15", check_out: "2019-3-20")
      # test_reserve2 = Reservation.new(2, check_in: "2019-3-24", check_out: "2019-3-30")
      # test_reserve3 = Reservation.new(2, check_in: "2019-3-24", check_out: "2019-3-30")

      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-24", "2019-3-30")
      test_manager.make_reservation("2019-3-24", "2019-3-30")
      check_in = "2019-3-24"
      check_out = "2019-3-30"

      expect(test_manager.find_reservation_date(check_in, check_out)).must_include test_manager.all_reservations[-1]
      expect(test_manager.find_reservation_date(check_in, check_out)).must_include test_manager.all_reservations[-2]
    end
  end

  describe "#find_available_rooms" do
    it "returns list of available rooms - not booked for given dates" do
      test_manager = Reservation_Manager.new
      check_in = "2019-4-5"
      check_out = "2019-4-7"
      available_rooms = test_manager.find_available_rooms(check_in, check_out)

      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms).must_equal test_manager.all_rooms
    end
  end
end
