require "date"
require_relative "spec_helper"
require "pry"

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
  it "adds reservation to reservation list" do
    expect(@frontdesk.reservations[0]).must_be_instance_of Hotel::Reservation
  end
  it "assigns an available room to the reservation" do
  end
  it "raises and argument error if no rooms are available for that date" do
  end
end

describe "Frontdesk find_reservation_by_date()" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    @frontdesk.request_reservation("Agatha Christie", "2019-05-20", 2)
    @frontdesk.request_reservation("Nnedi Okorafor", "2018-5-20", 2)
  end
  it "returns a list of reservations by date" do
    known_reservations = @frontdesk.find_reservation_by_date("2019-05-20")
    no_reservation = @frontdesk.find_reservation_by_date("2017-05-20")
    expect(known_reservations).must_be_instance_of Array
    expect(known_reservations[0]).must_be_instance_of Hotel::Reservation
    expect(known_reservations[0].name).must_equal "Agatha Christie"
    expect(no_reservation).must_be_nil
  end
end

describe "Frontdesk find_available_rooms" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    @reservation1 = @frontdesk.request_reservation("Agatha Christie", "2019-05-20", 2)
    @reservation2 = @frontdesk.request_reservation("Nnedi Okorafor", "2019-5-20", 2)
  end
  it "returns an array of available rooms" do
    dates = @reservation1.reserved_nights
    available_rooms = @frontdesk.find_available_rooms(dates)
    expect(available_rooms).must_be_instance_of Array
    expect(available_rooms[0]).must_be_instance_of Hotel::Room
    expect(available_rooms.length).must_equal 18
  end
  it "raises argument error if there are no available rooms" do
    18.times do
      reservation3 = @frontdesk.request_reservation("Agatha Christie", "2019-05-20", 2)
    end
    dates = @reservation1.reserved_nights
    expect { @frontdesk.find_available_rooms(dates) }.must_raise ArgumentError
  end
end
