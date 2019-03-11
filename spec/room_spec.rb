require_relative 'spec_helper'

describe "created room class" do
  it "is an instance of room" do
  room = Room.new
  expect(room).must_be_kind_of Room
  end
end
