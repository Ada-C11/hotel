require 'spec_helper.rb'
require 'date'

describe "Scheduler class" do
  describe "initialize" do
    let(:scheduler1) {
      Scheduler.new
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
      Scheduler.new
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
      Scheduler.new
    }

    it "adds a new reservation to a given room" do
      list_length_before = scheduler3.room_map[20].reservations.length
      date_range = Time_Interval.new(Date.parse("2019-06-12"), Date.parse("2019-06-15"))
      scheduler3.reserve_room(20, date_range)
      expect(scheduler3.room_map[20].reservations.length).must_equal list_length_before + 1
    end
  end
end