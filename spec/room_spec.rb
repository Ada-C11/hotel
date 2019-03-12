require_relative 'spec_helper'

describe "the class named Room" do
  describe "initialize" do
    before do 
      @room = Hotel::Room.new (
      room_number: 1,
      status: :AVAILABLE,
    )
    end

    it "creates an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end
end