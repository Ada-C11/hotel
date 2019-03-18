require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Reservation_Manager" do
  before do
    @Reservation_Manager = Hotel::Reservation_Manager.new
  end

  it "has an array of all rooms in hotel" do
    expect(@hotel.rooms).must_be_kind_of Array
  end

  it "has 20 rooms in the hotel" do
    expect(@hotel.rooms.length).must_equal 20
  end

  it "each index of the array is an instance of class" do
    expect(@hotel.rooms[0]).must_be_kind_of Hotel::Room
  end
end

describe "see_rooms method" do
  before do
    @hotel = Hotel::Reservation_Manager.new
  end

  it "returns an Array of rooms in hotel" do
    expect(@hotel.see_rooms).must_be_kind_of Array
  end

  it "returns an Array of correct length" do
    expect(@hotel.see_rooms.length).must_equal 20
  end
end

describe "reserve_room method" do
  before do
    @hotel = Hotel::Reservation_Manager.new
    @date_1 = Date.new(2018, 6, 6)
    @date_2 = Date.new(2018, 6, 9)
    @all_rooms_available = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    @input_1 = { name: "Kittywampus",
                room_id: 2,
                check_in_date: @date_1,
                check_out_date: @date_2 }
  end

  it "adds a reservation to the array of all reservations for a room" do
    @hotel.reserve_room(@input_1)
    expect(@hotel.rooms[1].reservations[0].name).must_equal "Kittywampus"
  end

  it "checks against room availbility and returns an Argument error if the date range is filled." do
    @all_rooms_available.each do |i|
      @input_2 = { name: "Moony",
                  room_id: i,
                  check_in_date: @date_1,
                  check_out_date: @date_2 }
      @hotel.reserve_room(@input_2)
    end
    expect { @hotel.reserve_room(@input_1) }.must_raise ArgumentError
  end
end

describe "list_reservations" do
  it "returns an array of reservations" do
    reservations = @Reservation_Manager.list_reservations(Date.new(2019, 3, 31))
    expect(reservations).must_be_kind_of Array
    expect(reservations.first).must_be_kind_of Hotel::Reservation
  end
end

describe "lists_rooms" do
  before do
    @new_room = Hotel::Room.new(id: 1)
  end

  it "returns an array of rooms" do
    room = @Reservation_Manager.see_rooms(Date.new(2019, 3, 31))
    expect(room).must_be_kind_of Array
    expect(room.first).must_be_kind_of Hotel::Room
  end

  it "can retrieve info about the rooms in rooms array" do
    @Reservation_Manager.rooms << @new_room
    expect(@Reservation_Manager.rooms.last.id).must_equal @new_room.id
    expect(@Reservation_Manager.rooms.last).must_be_kind_of Hotel::Room
  end

  it "returns rooms array" do
    expect(@Reservation_Manager.see_rooms).length.must_equal 20
  end
end
