require "spec_helper"

describe "Room" do
  it "is an instance of Room" do
    expect(Room.new(1)).must_be_instance_of Room
  end
end
