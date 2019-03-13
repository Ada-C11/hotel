require_relative "spec_helper"
describe "RESERVATION MANAGER TESTS" do
  describe "Reservation Manager class initialization & set up" do
    it "will return an instance of Reservation_Manager" do
      test_manager = Reservation_Manager.new
      expect(test_manager).must_be_kind_of Reservation_Manager
    end
  end

  describe "#make_reservation in Reservation Manager" do
    it "will contain a collection of Reservation instances" do
      test_manager = Reservation_Manager.new
      check_in = "2019-3-15"
      check_out = "2019-3-20"

      test_manager.make_reservation(check_in, check_out)
      expect(test_manager.all_reservations).must_be_kind_of Array

      test_manager.make_reservation(check_in, check_out)
      expect(test_manager.all_reservations[0]).must_be_kind_of Reservation
    end
    it "one new reservation updates all_reservations" do
      #initialize
      test_manager = Reservation_Manager.new

      #set up
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      expect(test_manager.all_reservations.length).must_equal 1
    end

    it "multiple reservations returns the correct number of reservations" do
      test_manager = Reservation_Manager.new

      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-24", "2019-3-30")
      test_manager.make_reservation("2019-3-24", "2019-3-30")

      expect(test_manager.all_reservations.length).must_equal 3
    end

    it "can make reservation when check in is another check out" do
      test_manager = Reservation_Manager.new
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-20", "2019-3-21")

      check_rooms = test_manager.find_available_rooms("2019-3-15", "2019-3-21")
      first_reserve_room = test_manager.all_reservations[0].room
      second_reserve_room = test_manager.all_reservations[1].room

      puts "These are all unavailable rooms"
      test_manager.all_reservations.each do |reservation|
        puts "#{reservation.room}"
      end

      expect(check_rooms.length).must_equal 19
      expect(first_reserve_room).must_equal second_reserve_room
    end

    it "must have different rooms if check in is day before another check out" do
      test_manager = Reservation_Manager.new
      reserve_1 = test_manager.make_reservation("2019-3-15", "2019-3-20")
      reserve_2 = test_manager.make_reservation("2019-3-19", "2019-3-21")

      puts "reserve 1 room: #{reserve_1}"
      puts "reserve 2 room: #{reserve_2}"
      expect(reserve_1.room).wont_equal reserve_2.room
    end
  end

  describe "#find_reservation_date" do
    it "will return collection of Reservations when given a specific date range" do
      test_manager = Reservation_Manager.new

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
    it "returns list of available rooms - dates don't coincide" do
      test_manager = Reservation_Manager.new
      check_in = "2019-4-5"
      check_out = "2019-4-7"
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      check_rooms = test_manager.find_available_rooms(check_in, check_out)
      available_rooms = (1..20).map { |i| i }

      expect(check_rooms).must_be_kind_of Array
      expect(check_rooms.length).must_equal 20
    end

    it "returns list of available rooms - dates overlap" do
      test_manager = Reservation_Manager.new
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-13", "2019-3-19")
      check_in = "2019-3-18"
      check_out = "2019-3-21"

      check_rooms = test_manager.find_available_rooms(check_in, check_out)

      expect(check_rooms.length).must_equal 18
    end
  end
end
