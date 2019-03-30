require_relative "spec_helper"
require "pry"

describe "Concierge class" do
  describe "Initialize" do
    before do
      @concierge = Hotel::Concierge.new
    end

    it "is an instance of Concierge" do
      expect(@concierge).must_be_kind_of Hotel::Concierge
    end

    it "loads a list of all rooms" do
      expect(@concierge.all_rooms).must_be_kind_of Array
    end
  end

  describe "See all rooms method" do
    before do
      @concierge = Hotel::Concierge.new
    end

    it "returns an array containing all hotel rooms" do
      expect(@concierge.all_rooms).must_be_kind_of Array
    end

    it "contains instances of Rooms" do
      expect(@concierge.all_rooms[0]).must_be_instance_of Hotel::Room
    end

    it "contains 20 rooms" do
      expect(@concierge.all_rooms.count).must_equal 20
    end

    it "correctly numbers each room" do
      expect(@concierge.all_rooms[1].room_number).must_equal 2
    end
  end

  describe "Reserve room method" do
    before do
      @concierge = Hotel::Concierge.new
    end

    it "updates the Concierge Reservations array" do
      @res_count = @concierge.reservations.length
      @date_range = Hotel::DateRange.new("2019-05-01", "2019-05-03")
      @reservation1 = @concierge.reserve_room(@date_range)
      expect(@concierge.reservations.length).must_equal (@res_count + 1)
    end

    it "updates the Room's list of reservations" do
      date_range = Hotel::DateRange.new("2019-05-01", "2019-05-03")
      @reservation2 = @concierge.reserve_room(date_range)
    end

    # it "updates the list of reservations" do
    #   expect(@concierge.reservations.length).must_equal 3
    # end

    # it "contains instances of reservations" do
    #   expect(@concierge.reservations[2]).must_be_instance_of Hotel::Reservation
    # end
  end

  describe "view Reservations by date method" do
    before do
      @concierge = Hotel::Concierge.new
      @date_range = Hotel::DateRange.new("2019-01-01", "2019-01-04")
      @date_range2 = Hotel::DateRange.new("2019-3-1", "2019-3-2")
      @date_range3 = Hotel::DateRange.new("2020-1-10", "2020-1-20")

      res1 = @concierge.reserve_room(@date_range)
      res2 = @concierge.reserve_room(@date_range2)
      res3 = @concierge.reserve_room(@date_range3)
      res4 = @concierge.reserve_room(@date_range3)
    end

    it "returns an array of matching dates" do
      expect(@concierge.view_reservations_by_date(@date_range3)).must_be_kind_of Array
    end
    it "can display reservations by date range" do
      date_range = Hotel::DateRange.new("2020-1-20", "2020-1-20")
      expect(@concierge.view_reservations_by_date(date_range).first).must_be_instance_of Hotel::Reservation
    end

    it "accurately returns all reservations for specified date range" do
      date_range = Hotel::DateRange.new("2020-1-20", "2020-1-20")
      expect(@concierge.view_reservations_by_date(date_range).length).must_equal 2
    end
  end

  describe "View Available Rooms method" do
    before do
      @concierge = Hotel::Concierge.new
      @date_range = Hotel::DateRange.new("2019-01-01", "2019-01-04")
      res1 = @concierge.reserve_room(@date_range)
    end

    it "returns a list of available rooms" do
      @date_range = Hotel::DateRange.new("2019-01-01", "2019-01-03")
      expect(@concierge.view_available_rooms(@date_range)).must_be_kind_of Array
    end

    it "returns the correct amount of available rooms" do
      @date_range = Hotel::DateRange.new("2019-01-01", "2019-01-03")
      expect(@concierge.view_available_rooms(@date_range).length).must_equal 19
    end

    it "displays only rooms available during the given date range" do
      date_range2 = Hotel::DateRange.new("2019-01-01", "2019-01-04")
      date_range3 = Hotel::DateRange.new("2020-3-1", "2020-3-2")
      res1 = @concierge.reserve_room(date_range2)
      res2 = @concierge.reserve_room(date_range3)
      @date_range = Hotel::DateRange.new("2019-01-01", "2019-01-03")

      expect(@concierge.view_available_rooms(@date_range).length).must_equal 18
      expect((@concierge.reservations).length).must_equal 3
    end

    it "lets the user know that no rooms are available" do
      concierge = Hotel::Concierge.new
      date_range = Hotel::DateRange.new("2019-01-01", "2019-01-04")
      20.times do
        concierge.reserve_room(date_range)
      end
      expect { concierge.view_available_rooms(date_range) }.must_raise ArgumentError
    end
  end
end
