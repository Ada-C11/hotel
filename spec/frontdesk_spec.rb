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
    @frontdesk = Hotel::Frontdesk.new
    reservation = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    @frontdesk.request_reservation(reservation)
  end
  it "adds reservation to reservation list" do
    expect(@frontdesk.reservations[0]).must_be_instance_of Hotel::Reservation
  end
  it "assigns an available room to the reservation" do
  end
  it "raises and argument error if no rooms are available for that date" do
  end
end

describe "Frontdesk request_block" do
  it "reserves a block of rooms" do
    #raise argument error if user tries to block more than 5 rooms
    #expect block of rooms shouldn't be listed as available
    #expect block of rooms should create correct number of rooms
    #expect block should have a status of some sort
    #expect Argument Error if there aren't enough rooms for that time period
    #expect an additional block of rooms cant be created that overlaps
    #with another block
  end
  it "allows reservations to be made by those with block access" do
    #expect that given the right 'password', user should be able
    #to access that block
    #expect user can only book for those precise block dates
    #expect cost should be adjusted for block price
    #expects user can see if given block has any rooms available
    #expects reservation will be listed when user searches by date
    #expect user can reserve a specific room in the block
  end
end

describe "Frontdesk find_reservation_by_date()" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    reservation = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    reservation2 = Hotel::Reservation.new("Nnedi Okorafor", "2018-05-20", 2)
    @frontdesk.request_reservation(reservation)
    @frontdesk.request_reservation(reservation2)
  end
  it "returns a list of reservations by date" do
    known_reservation = @frontdesk.find_reservation_by_date("2019-05-20")
    no_reservation = @frontdesk.find_reservation_by_date("2017-05-20")
    expect(known_reservation).must_be_instance_of Array
    expect(known_reservation[0]).must_be_instance_of Hotel::Reservation
    expect(known_reservation[0].name).must_equal "Agatha Christie"
    expect(no_reservation).must_be_nil
  end
end

describe "Frontdesk find_available_rooms" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    pending_res1 = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    pending_res2 = Hotel::Reservation.new("Nnedi Okorafor", "2019-05-20", 2)
    @reservation1 = @frontdesk.request_reservation(pending_res1)
    @reservation2 = @frontdesk.request_reservation(pending_res2)
  end
  it "returns an array of available rooms" do
    dates = @reservation1.reserved_nights
    available_rooms = @frontdesk.find_available_rooms(dates)
    expect(available_rooms).must_be_instance_of Array
    expect(available_rooms[0]).must_be_instance_of Hotel::Room
    expect(available_rooms.length).must_equal 18
  end
  it "raises argument error if there are no available rooms" do
    reservation3 = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    18.times do
      @frontdesk.request_reservation(reservation3)
    end
    dates = reservation3.reserved_nights
    expect { @frontdesk.find_available_rooms(dates) }.must_raise ArgumentError
  end
end
