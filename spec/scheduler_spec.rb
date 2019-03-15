require 'spec_helper.rb'

describe "Scheduler module" do
  before do
    Scheduler.load_all_rooms
    @d1 = Time_Interval.new("2019-06-15", "2019-06-20")
    @num_reservations_before = Scheduler::ALL_RESERVATIONS.length

    20.times do
      Scheduler.make_reservation(@d1)
    end
  end

  describe "load_all_rooms method" do
    it "scheduler contains a list of room" do
      expect(Scheduler::ALL_ROOMS).must_be_instance_of Array
    end

    it "returns an array containing room instances" do
      Scheduler::ALL_ROOMS.each do |room|
        expect(room).must_be_instance_of Room
      end
    end

    it "returns an array of size 20" do
      expect(Scheduler::ALL_ROOMS.length).must_equal 20
    end

    it "each room has an id between 1 and 20" do
      Scheduler::ALL_ROOMS.each do |room|
        expect(room.id >= 1 && room.id <= 20).must_equal true
      end
    end
  end

  describe "find_available_room method" do
    it "returns an integer" do
      duration = Time_Interval.new("2019-02-14", "2019-02-16")
      expect(Scheduler.find_available_room(duration)).must_be_instance_of Integer
    end
  end

  describe "make_reservation method" do
    it "adds a new reservation to the list of reservations" do
      expect(Scheduler::ALL_RESERVATIONS).must_be_instance_of Array
      expect(Scheduler::ALL_RESERVATIONS.length).must_equal @num_reservations_before + 20

      Scheduler::ALL_RESERVATIONS.each do |reservation|
        expect(reservation).must_be_instance_of Reservation
      end
    end
  end

  describe "list_reservations method" do
    it "returns an array of reservations" do
      test_list = Scheduler.list_reservations("2019-04-02")
      expect(test_list).must_be_instance_of Array
    end

    it "returns a list of 20 reservations when the date requested is within the booking periods" do
      test_list = Scheduler.list_reservations("2019-06-17")
      expect(test_list.length).must_equal 20
    end
  end
end