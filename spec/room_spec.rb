require_relative "spec_helper"

describe "Room class" do
  let(:room) { Hotel::Room.new(room_number: 1) }
  let(:night) { Date.new(2000, 1, 8) }

  it "is able to instantiate" do
    expect(room).must_be_kind_of Hotel::Room
    expect(room.rate).must_equal 200
    expect(room.number).must_equal 1
    expect(room.booked_nights).must_be_kind_of Array
    expect(room.booked_nights).must_equal []
  end

  it "can check if room is available" do
    expect(room.available?(night: night)).must_equal true

    room.booked_nights << night

    expect(room.available?(night: night)).must_equal false
  end
end
