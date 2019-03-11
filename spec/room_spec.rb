require_relative "spec_helper"

describe "Room.new" do
  it "creates and instance of Room" do
    room = Hotel::Room.new(1)
    expect(room).must_be_instance_of Hotel::Room
  end
end

describe "self.add_reservation" do
  before do
    checkin_date = Date.parse("2019-05-20")
    checkout_date = Date.parse("2019-05-23")
    @room = Hotel::Room.new(1)
    @room.add_reservation(checkin_date.to_s, checkout_date.to_s)
  end

  it "adds booked dates to rooms availability array" do
    expect(@room.availability).must_be_kind_of Array
  end
end
