require 'spec_helper.rb'

describe "Scheduler module" do
  describe "list_all_rooms method" do
    it "returns an array" do
      expect(Scheduler.list_all_rooms).must_be_instance_of Array
    end

    it "returns an array containing room instances" do
      Scheduler.list_all_rooms.each do |room|
        expect(room).must_be_instance_of Room
      end
    end

    it "returns an array of size 20" do
      expect(Scheduler.list_all_rooms.length).must_equal 20
    end
  end
end