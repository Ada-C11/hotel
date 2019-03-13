require_relative "spec_helper"

describe "Reservation_manager instantiation" do
  it "is an instance of Reservation Manager" do
    guest = Hotel::ReservationManager.new
    expect(guest).must_be_kind_of Hotel::ReservationManager
  end
end

describe "all_rooms method" do
  it "can list all rooms in the hotel" do
    rooms = Hotel::ReservationManager.new
    expect(rooms.all_rooms.length).must_equal 20
  end
end
