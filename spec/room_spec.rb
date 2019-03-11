require_relative "spec_helper"

describe "Room.new" do
  it "creates and instance of Room" do
    room = Hotel::Room.new(1)
    expect(room).must_be_instance_of Hotel::Room
  end
end
