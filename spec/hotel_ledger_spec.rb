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

  describe "must make a reservation" do
    booking = Hotel::Hotel_ledger.new
    expect(
      booking.make_a_reservation(
      phone_number: 1234567890,
      number_of_rooms: 1,
      start_date: Date.new(2019, 3, 13),
      end_date: Date.new(2019, 3, 14)
      )
  end
  # make a before block, test that array gets larger, .length = elements in array
end
