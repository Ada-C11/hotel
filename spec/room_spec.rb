require_relative "spec_helper"

describe "room class" do
  it "returns an instance of class Room" do
    room = Room.new

    expect(room).must_be_kind_of Room
  end
end
