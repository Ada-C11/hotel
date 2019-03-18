require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "self.search_room_id method" do
  before do
  end
  
  it "returns an instance of Room" do
  end
end
  
describe "link_room_id_with_reservation_id" do
  before do
  end
  
  it "given a list of rooms and a room id it adds a reservation to the room's reservation records" do
  end
  
describe "is_date_range_valid?" do
  before do
  end

  it "raises an Error if the the check out date is before the check in" do
  end
end
  

describe "self.binary_find_avail_room" do
  before do
  end
  
  # different kinds of overlapping:
  # same dates - rejects
  it "returns true, if the reservation request shares the same dates as a reserved room" do
  end
  
  # start date overlaps the middle of existing reservation - rejects
  it "returns true if check in date is in the middle dates of a reserved room" do
  end
  
  # end date overlaps the middle of existing reservation - rejects
  it "returns true if the check out date is in the middle dates of a reserved room" do
  end

  # occurs within the existing date range - rejects
  it "returns true if the reservation check in date and check out date is in the middle dates of a reserved room" do
  end
  
  # returns false - overlap on checkin/out days is acceptable
  it "returns false if the reservation check in date is on the check out day of another reservation" do
  end
  
  # returns false - overlap on checkin/out days is acceptable
  it "returns false if the reservation check out date is on the check in day of another reservation" do
  end
end

describe "self.sort_reservations_by_date" do
  it "sorts reservations from soonest to latest dates" do
  end
end
  
describe "binary_search_for_reservations by date" do
  before do
  end
  
  it "returns the index position of the reservation" do
  end
end
  
  