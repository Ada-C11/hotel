require_relative "spec_helper"

describe "Room.new" do
  it "creates and instance of Room" do
    room = Hotel::Room.new(1)
    expect(room).must_be_instance_of Hotel::Room
  end
end

describe "add_reservation" do
  before do
    checkin_date = Date.parse("2015-05-20")
    @reservation = Hotel::Reservation.new("Amy Martinsen", checkin_date.to_s, 3)
    @room = Hotel::Room.new(1)
    @room.add_reservation(@reservation)
  end
  it "adds booked dates to rooms availability array" do
    expect(@room.availability).must_be_kind_of Array
  end
  it "calculates nights booked per reservation" do
    expect(@room.availability[0][1].to_s).must_equal "2015-05-21"
  end
end
