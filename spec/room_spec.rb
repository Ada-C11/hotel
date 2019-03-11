require_relative "spec_helper"

describe "Room class" do
  it "is able to instantiate" do
    room = Room.new(1)

    expect(room).must_be_kind_of Room
  end
end
