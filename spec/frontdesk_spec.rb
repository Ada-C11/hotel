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

describe "Frontdesk find_reservation_by_date()" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    @frontdesk.request_reservation("Agatha Christie", "2019-05-20", 2)
    @frontdesk.request_reservation("Nnedi Okorafor", "2019-5-19", 2)
  end
  it "returns reservations by date" do
    @reservation = @frontdesk.find_reservation_by_date("2019-05-20")
    @no_reservation = @frontdesk.find_reservation_by_date("2017-05-20")
    expect(@reservation).must_be_instance_of Array
    expect(@reservation[0]).must_be_instance_of Hotel::Reservation
    expect(@reservation[1].name).must_equal "Nnedi Okorafor"
    expect(@no_reservation).must_be_nil
  end
end
