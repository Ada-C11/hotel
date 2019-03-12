require 'spec_helper.rb'

describe "Room class" do
  describe "initialize" do
    it "returns an instance of room object" do
      ids = [3, 4, 5]
      ids.each do |id|
        expect(Room.new(id)).must_be_kind_of Room
      end
    end
  end
end