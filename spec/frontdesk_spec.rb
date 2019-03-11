require "date"

require_relative "spec_helper"

describe "Frontdesk.new" do
  before do
    @frontdesk = Hotel::Frontdesk.new
  end
  it "creates and instance of Frontdesk" do
    expect(@frontdesk).must_be_instance_of Hotel::Frontdesk
  end

  it "creates a list of 20 rooms at the hotel" do
    expect(@frontdesk.rooms).must_be_instance_of Array
    expect(@frontdesk.rooms.length).must_equal 20
    expect(@frontdesk.rooms.first.number).must_equal 1
    expect(@frontdesk.rooms.last.number).must_equal 20
  end
end

describe "Frontdesk request_reservation" do
  before do
    checkin_date = Date.parse("2019-05-20")
    @frontdesk = Hotel::Frontdesk.new
    @frontdesk.request_reservation("Agatha Christie", checkin_date.to_s, 2)
  end
  # it "checks for an available room" do
  # end
  it "adds reservation to reservation list" do
    expect(@frontdesk.reservations[0]).must_be_instance_of Hotel::Reservation
  end
  it "assigns reservations a room number" do
    expect(@frontdesk.reservations.first.room_num).must_be_kind_of Integer
  end
end
