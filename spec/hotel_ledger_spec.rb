require_relative "spec_helper"

describe "Hotel Ledger class" do
  before do
    @rooms = Hotel::Hotel_ledger.new
  end

  it "must return an array for all rooms" do
    expect(@rooms.list_all_rooms).must_be_kind_of Array
  end

  it "can list all the hotel rooms" do
    expect(@rooms.list_all_rooms.length).must_equal 20
  end

  it "must return an array for reservations" do
    expect(@rooms.list_all_reservations).must_be_kind_of Array
  end
end

describe "Making a reservation" do
  before do
    @booking = Hotel::Hotel_ledger.new
  end
  it "must create a new reservation" do
    new_booking = @booking.make_reservation(
      1234567890,
      Date.new(2019, 3, 13),
      Date.new(2019, 3, 14),
    )
    expect(new_booking).must_be_kind_of Hotel::Reservation
  end
  # make a before block, test that array gets larger, .length = elements in array
end
