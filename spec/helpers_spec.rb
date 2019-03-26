require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "self.search_room_id method" do
  before do
    @hotel = Hotel::Reservation_Manager.new
  end

  it "returns an instance of Room" do
    expect(Hotel::Helpers.search_room_id(@hotel.rooms, 1)).must_be_kind_of Hotel::Room
    expect(Hotel::Helpers.search_room_id(@hotel.rooms, 20)).must_be_kind_of Hotel::Room
  end
end

describe "link_room_id_with_reservation_id" do
  before do
    @hotel = Hotel::Reservation_Manager.new
    @rooms = @hotel.rooms
    @input_1 = { name: "Mango Wild",
                room_id: 1,
                check_in_date: Date.new(2020, 9, 9),
                check_out_date: Date.new(2020, 9, 13) }
    @input_2 = { name: "Suki",
                room_id: 1,
                check_in_date: Date.new(2020, 9, 9),
                check_out_date: Date.new(2020, 9, 13) }
    @input_3 = { name: "Amos",
                room_id: 1,
                check_in_date: Date.new(2018, 9, 9),
                check_out_date: Date.new(2018, 9, 13) }
  end

  it "adds a reservation to the room's reservation records" do
    @reservation_1 = Hotel::Reservation.new(@input_2)
    @reservation_2 = Hotel::Reservation.new(@input_3)

    Hotel::Helpers.link_room_id_with_reservation_id(@rooms, 1, @reservation_1)
    expect(@rooms.first.reservations.first.name).must_equal "Suki"
    expect(@rooms.first.reservations.first.room_id).must_equal 1

    Hotel::Helpers.link_room_id_with_reservation_id(@rooms, 1, @reservation_2)
    expect(@rooms.first.reservations.first.name).must_equal "Amos"
    expect(@rooms.first.reservations.first.room_id).must_equal 1
  end

  it "raises an error if a reservation conflicts with an existing reservation" do
    @reservation_1 = Hotel::Reservation.new(@input_1)
    @reservation_2 = Hotel::Reservation.new(@input_2)
    Hotel::Helpers.link_room_id_with_reservation_id(@rooms, 1, @reservation_1)
    expect { Hotel::Helpers.link_room_id_with_reservation_id(@rooms, 1, @reservation_2) }.must_raise ArgumentError
  end
end

describe "is_date_range_valid?" do
  before do
    @input_1 = { name: "Misty Pines",
                room_id: 1,
                check_in_date: Date.new(2020, 1, 1),
                check_out_date: Date.new(2020, 1, 4) }
    @input_2 = { name: "Cocoa",
                room_id: 3,
                check_in_date: Date.new(2020, 1, 4),
                check_out_date: Date.new(2020, 1, 1) }
    @reservation = Hotel::Reservation.new(@input_1)
  end

  it "raises an Error if the the check out date is before the check in" do
    expect { Hotel::Reservation.new(@input_2) }.must_raise StandardError
  end
end

describe "self.binary_find_avail_room" do
  before do
    # range of dates
    @date_1 = Date.new(2020, 1, 14)
    @date_2 = Date.new(2020, 1, 18)
    # within range of dates
    @date_3 = Date.new(2020, 1, 15)
    @date_4 = Date.new(2020, 1, 17)
    # outside range of dates
    @date_5 = Date.new(2020, 1, 9)
    @date_6 = Date.new(2020, 1, 21)

    @input = { name: "Truffle",
              room_id: 1,
              check_in_date: @date_1,
              check_out_date: @date_2 }
    @reservation = Hotel::Reservation.new(@input)
    @reservations_array = [@reservation]
  end

  # different kinds of overlapping:
  # same dates - rejects
  it "returns true, if the reservation request shares the same dates as a reserved room" do
    @array_of_possible_dates = Hotel::Helpers.nights(@date_1, @date_2)
    expect(Hotel::Helpers.binary_search_for_avail_room(@reservations_array, @requested_dates)).must_equal true
  end

  # start date overlaps the middle of existing reservation - rejects
  it "returns true if check in date is in the middle dates of a reserved room" do
    @array_of_possible_dates = Hotel::Helpers.nights(@date_3, @date_4)
    expect(Hotel::Helpers.binary_search_for_avail_room(@reservations_array, @requested_dates)).must_equal true
  end

  # end date overlaps the middle of existing reservation - rejects
  it "returns true if the check out date is in the middle dates of a reserved room" do
    @requested_dates = Hotel::Helpers.nights(@date_5, @date_6)
    expect(Hotel::Helpers.binary_search_for_avail_room(@reservations_array, @requested_dates)).must_equal true
  end

  # occurs within the existing date range - rejects
  it "returns true if the reservation check in date and check out date is in the middle dates of a reserved room" do
    @requested_dates = Hotel::Helpers.nights(@date_3, @date_4)
    expect(Hotel::Helpers.binary_search_for_avail_room(@reservations_array, @requested_dates)).must_equal true
  end

  # returns false - overlap on checkin/out days is acceptable
  it "returns false if the reservation check in date is on the check out day of another reservation" do
    @requested_dates = Hotel::Helpers.nights(@date_2, @date_6)
    expect(Hotel::Helpers.binary_search_for_avail_room(@reservations_array, @requested_dates)).must_equal false
  end

  # returns false - overlap on checkin/out days is acceptable
  it "returns false if the reservation check out date is on the check in day of another reservation" do
    @requested_dates = Hotel::Helpers.nights(@date_5, @date_1)
    expect(Hotel::Helpers.binary_search_for_avail_room(@reservations_array, @requested_dates)).must_equal false
  end
end

describe "self.sort_reservations_by_date" do
  it "sorts reservations from soonest to latest dates" do
    @input_1 = { name: "Truffle",
                room_id: 1,
                check_in_date: Date.new(2020, 9, 9),
                check_out_date: Date.new(2020, 9, 13) }
    @reservation_1 = Hotel::Reservation.new(@input_1)
    @input_2 = { name: "Yellow Cat",
                room_id: 1,
                check_in_date: Date.new(2016, 7, 9),
                check_out_date: Date.new(2016, 7, 13) }
    @reservation_2 = Hotel::Reservation.new(@input_2)
    @input_3 = { name: "Poopy Nora",
                room_id: 1,
                check_in_date: Date.new(2018, 7, 9),
                check_out_date: Date.new(2018, 7, 13) }
    @reservation_3 = Hotel::Reservation.new(@input_3)
    @reservations = [@reservation_1, @reservation_2, @reservation_3]
    Hotel::Helpers.sort_by_date(@reservations)

    expect(@reservations.first.name).must_equal "Yellow Cat"
    expect(@reservations.last.name).must_equal "Truffle"
  end
end

describe "binary_search_for_reservations by date" do
  before do
  end

  it "returns the index position of the reservation" do
  end
end
