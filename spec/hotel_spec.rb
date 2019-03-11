require_relative "spec_helper"

describe "hotel class" do
  before do
    @hotel = Hotel.new
  end

  it "returns an object of type Hotel with instance variables" do
    expect(@hotel).must_be_kind_of Hotel
    expect(@hotel).must_respond_to :rooms, :reservations
  end

  it "initializes an array of rooms" do
    expect(@hotel.rooms).must_be_kind_of Array
    expect(@hotel.rooms.count).must_equal 20
  end
end

describe "list rooms and reservations" do
  before do
    @hotel = Hotel.new
    @hotel.rooms = [Room.new(3, 900)]
  end

  it "returns a formatted room" do
    expect(@hotel.list_rooms).must_equal "Room 3: $900.00 per night"
  end
end

describe "creates new reservation" do
  before do
    @hotel = Hotel.new
    @start_time = Date.new(2019, 3, 9)
    @end_time = Date.new(2019, 3, 11)

    @start_time2 = Date.new(2019, 4, 9)
    @end_time2 = Date.new(2019, 4, 11)
  end

  it "generates an id for the new reservation" do
    expect(@hotel.create_res_id).must_equal 1
  end

  it "creates new Reservation objects and adds them to reservations array" do
    @hotel.add_reservation(@start_time, @end_time)

    @hotel.add_reservation(@start_time2, @end_time2)

    expect(@hotel.reservations.count).must_equal 2
    expect(@hotel.reservations[0]).must_be_kind_of Reservation
    expect(@hotel.reservations[1].id).must_equal 2
  end

  it "raises an exception when invalid date range is entered" do
    @end_time_bad = Date.new(2018, 3, 9)

    expect { @hotel.add_reservation(@start_time, @end_time_bad) }.must_raise ArgumentError
  end
end
