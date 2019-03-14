require 'spec_helper.rb'

describe "Scheduler module" do
  before do
    Scheduler.load_all_rooms
    @d1 = Time_Interval.new("2019-06-15", "2019-06-20")
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
      expect(Scheduler.find_available_room(@d1)).must_be_instance_of Integer
    end
  end

  describe "make_reservation method" do
    it "adds a new reservation to the list of reservations" do
      num_reservations_before = Scheduler::ALL_RESERVATIONS.length

      20.times do
        Scheduler.make_reservation(@duration)
      end

      expect(Scheduler::ALL_RESERVATIONS).must_be_instance_of Array
      expect(Scheduler::ALL_RESERVATIONS.length).must_equal num_reservations_before + 20

      Scheduler::ALL_RESERVATIONS.each do |reservation|
        expect(reservation).must_be_instance_of Reservation
      end
    end
  end

  describe "list_reservation method" do
    it "returns an array of reservations" do
      expect(Scheduler.list_reservations("2019-04-02")).must_be_instance_of Array
    end
  end
end