require_relative "../spec/spec_helper"

describe "Room.new" do
  it "creates and instance of Room" do
    room = Room.new
    expect(room).must_be_instance_of Room
  end
end
