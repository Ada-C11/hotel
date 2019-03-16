require 'spec_helper.rb'
require 'date'

describe "Scheduler class" do
  describe "initialize" do
    let(:scheduler1) {
      Scheduler.new(20)
    }

    it "returns an instance of scheduler" do
      expect(scheduler1).must_be_instance_of Scheduler
    end

    it "returns a scheduler with a map of 20 rooms" do
      expect(scheduler1.room_map).must_be_instance_of Hash
      expect(scheduler1.room_map.keys.length).must_equal 20
    end
  end

  describe "get_room_ids method" do
    let(:scheduler2) {
      Scheduler.new(20)
    }

    it "returns a list of ids for all rooms in the hotel" do
      expect(scheduler2.get_room_ids).must_be_instance_of Array
    end

    it "returns a list of 20 ids" do
      expect(scheduler2.get_room_ids.length).must_equal 20
    end
  end

  describe "reserve_room method" do
    let(:scheduler3) {
      Scheduler.new(1)
    }

    it "adds a new reservation to a given room" do
      list_length_before = scheduler3.room_map[1].reservations.length
      date_range = Time_Interval.new(Date.parse("2019-06-12"), Date.parse("2019-06-15"))
      scheduler3.reserve_room(1, date_range)
      expect(scheduler3.room_map[1].reservations.length).must_equal list_length_before + 1
    end
  end

  describe "get_reservations method" do
    let(:scheduler4) {
      Scheduler.new(3)
    }

    it "returns a list of ids of reserved rooms for a given date" do
      date_range1 = Time_Interval.new(Date.parse("2019-06-12"), Date.parse("2019-06-15"))
      scheduler4.reserve_room(1, date_range1)
      scheduler4.reserve_room(2, date_range1)
      scheduler4.reserve_room(3, date_range1)

      room_ids = [1, 2, 3]
      return_list = scheduler4.get_reservations(Date.parse("2019-06-12"))
      expect(scheduler4.get_reservations(Date.parse("2019-06-12"))).must_equal room_ids
    end
  end

  describe "get_available_rooms method" do
    it "returns a list of one room_id when two rooms are booked in a three room hotel" do
      scheduler = Scheduler.new(3)
      scheduler.reserve_room(1, Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      scheduler.reserve_room(2, Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))

      return_list = scheduler.get_available_rooms(Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))

      expect(return_list.length).must_equal 1
      expect(return_list[0]).must_equal 3
    end

    it "returns a list of two room_ids when one room is booked in a three room hotel" do
      scheduler = Scheduler.new(3)
      scheduler.reserve_room(1, Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))

      return_list = scheduler.get_available_rooms(Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))

      expect(return_list.length).must_equal 2
      expect(return_list[0]).must_equal 2
      expect(return_list[1]).must_equal 3
    end

    it "returns an empty list when no room is available in a three room hotel" do
      scheduler = Scheduler.new(3)
      scheduler.reserve_room(1, Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      scheduler.reserve_room(2, Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      scheduler.reserve_room(3, Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      return_list = scheduler.get_available_rooms(Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))

      expect(return_list.length).must_equal 0
    end
  end

end