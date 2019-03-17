require 'spec_helper.rb'
require 'date'

describe "Scheduler class" do
  describe "initialize" do
    let(:scheduler) {
      Hotel::Scheduler.new(20)
    }

    it "returns an instance of scheduler" do
      expect(scheduler).must_be_instance_of Hotel::Scheduler
    end

    it "returns a scheduler with a map of 20 rooms" do
      expect(scheduler.get_room_ids.length).must_equal 20
    end
  end

  describe "get_room_ids method" do
    let(:scheduler) {
      Hotel::Scheduler.new(3)
    }

    it "returns a list of ids for all rooms in the hotel" do
      expect(scheduler.get_room_ids).must_be_instance_of Array
    end

    it "returns a list of 3 ids" do
      expect(scheduler.get_room_ids).must_equal [0, 1, 2]
    end
  end

  describe "reserve_room method" do
    let(:scheduler) {
      Hotel::Scheduler.new(2)
    }

    it "adds a new reservation to a given room" do
      reservations = scheduler.get_reservations(Date.parse("2019-06-12"))
      expect(reservations.length).must_equal 0
      date_range = Hotel::Time_Interval.new(Date.parse("2019-06-12"), Date.parse("2019-06-15"))

      scheduler.reserve_room(0, date_range)
      reservations = scheduler.get_reservations(Date.parse("2019-06-12"))
      expect(reservations.length).must_equal 1
      expect(reservations[0].room_id).must_equal 0
      expect(reservations[0].total_cost).must_equal 600
    end
    # exception

    # reserve same date range for two different rooms
  end

  describe "get_reservations method" do
    let(:scheduler) {
      Hotel::Scheduler.new(3)
    }

    it "returns a list of reservations for a given date" do
      expect(scheduler.get_reservations(Date.parse("2019-06-12")).length).must_equal 0

      date_range = Hotel::Time_Interval.new(Date.parse("2019-06-12"), Date.parse("2019-06-15"))
      scheduler.reserve_room(0, date_range)
      scheduler.reserve_room(1, date_range)
      scheduler.reserve_room(2, date_range)

      return_list = scheduler.get_reservations(Date.parse("2019-06-12"))
      expect(return_list.length).must_equal 3
    end

    #add reservation
    # ceck for a differnt date and ssee nothing is retruend
  end

  describe "get_available_rooms method" do
    it "returns a list of one room_id when two rooms are booked in a three room hotel" do
      scheduler = Hotel::Scheduler.new(3)
      initial_list = scheduler.get_available_rooms(Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      expect(initial_list.length).must_equal 3

      scheduler.reserve_room(0, Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      scheduler.reserve_room(1, Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))

      return_list = scheduler.get_available_rooms(Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))

      expect(return_list.length).must_equal 1
      expect(return_list[0]).must_equal 2
    end

    it "returns an empty list when no room is available in a three room hotel" do
      scheduler = Hotel::Scheduler.new(3)
      initial_list = scheduler.get_available_rooms(Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      expect(initial_list.length).must_equal 3

      scheduler.reserve_room(0, Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      scheduler.reserve_room(1, Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      scheduler.reserve_room(2, Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))
      return_list = scheduler.get_available_rooms(Hotel::Time_Interval.new(Date.parse("2019-12-10"), Date.parse("2019-12-15")))

      expect(return_list.length).must_equal 0
    end

    #reserve the same room and expect an excpetion
  end

  describe "create_block method" do
    before do
      @scheduler = Hotel::Scheduler.new(6)
      @scheduler.reserve_room(0, Hotel::Time_Interval.new(Date.parse("2019-05-01"), Date.parse("2019-05-04")))
    end

    it "raises an argument error if at least one of the rooms is unavailable for a given date range" do
      room_ids = [0, 2, 5]
      discounted_rate = 180
      expect {
        @scheduler.create_block(Hotel::Time_Interval.new(Date.parse("2019-05-01"), Date.parse("2019-05-04")), 
                              room_ids, discounted_rate)
      }.must_raise ArgumentError 
    end

    it "raises an argument error when there is an attempt to reserve a room that is part of a block" do
      room_ids = [0, 2, 5]
      discounted_rate = 180
      @scheduler.create_block(Hotel::Time_Interval.new(Date.parse("2019-05-15"), Date.parse("2019-05-20")), 
                              room_ids, discounted_rate)
      
      expect {
        @scheduler.reserve_room(0, Hotel::Time_Interval.new(Date.parse("2019-05-15"), Date.parse("2019-05-20")), 
                                room_ids, discounted_rate)
      }.must_raise ArgumentError
    end

    it "raises an argument error when there is an attempt to create a block that overlaps with existing blocks" do
      room_ids = [0, 2, 5]
      discounted_rate = 180
      @scheduler.create_block(Hotel::Time_Interval.new(Date.parse("2019-05-15"), Date.parse("2019-05-20")), 
                              room_ids, discounted_rate)
      
      expect {
        room_ids = [2, 3, 4]
        @scheduler.create_block(Hotel::Time_Interval.new(Date.parse("2019-05-15"), Date.parse("2019-05-20")), 
                                room_ids, discounted_rate)
      }.must_raise ArgumentError
    end
  end

  describe "block_has_available_room method" do
    before do
      @scheduler = Hotel::Scheduler.new(5)
      room_ids = [1, 2, 3]
      discounted_rate = 180
      duration = Hotel::Time_Interval.new(Date.parse("2019-03-14"), Date.parse("2019-03-18"))
      @block_id = @scheduler.create_block(duration, room_ids, discounted_rate)
    end

    it "returns true when there is an available room in a given block" do
      expect(@scheduler.block_has_available_room?(@block_id)).must_equal true
    end

    it "returns false when there is no available room in a given block" do
      @scheduler.reserve_room_in_block(@block_id, 1)
      @scheduler.reserve_room_in_block(@block_id, 2)
      @scheduler.reserve_room_in_block(@block_id, 3)
      expect(@scheduler.block_has_available_room?(@block_id)).must_equal false
    end
  end
end