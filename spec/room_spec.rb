require_relative "spec_helper"

describe Room do
  it "must be an instance of the room" do
    room = Room.new(3)
    expect(room).must_be_kind_of Room
  end
end
