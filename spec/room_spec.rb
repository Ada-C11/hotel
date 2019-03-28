require_relative "spec_helper"

describe "Room class" do
  let(:room) { Hotel::Room.new(room_number: 1) }
  let(:night) { Date.new(2000, 1, 8) }
  let(:nights) { [Date.new(2000, 1, 8), Date.new(2000, 1, 9)] }

  it "is able to instantiate" do
    expect(room).must_be_kind_of Hotel::Room
    expect(room.rate).must_equal 200
    expect(room.number).must_equal 1
    expect(room.booked_nights).must_be_kind_of Array
    expect(room.booked_nights).must_equal []
  end

  it "can check if room is available for a night" do
    expect(room.available?(night: night)).must_equal true

    room.booked_nights << night

    expect(room.available?(night: night)).must_equal false
  end

  it "can check if room is available for multiple nights" do
    expect(room.available?(nights: nights)).must_equal true

    room.booked_nights << night

    expect(room.available?(nights: nights)).must_equal false
  end

  it "raises ArgumentError if night or nights aren't given" do
    expect { room.available? }.must_raise ArgumentError
  end

  it "can book nights for room" do
    room.book(nights: [Date.new(2000, 1, 8), Date.new(2000, 1, 9)])

    expect(room.booked_nights.length).must_equal 2
    expect(room.booked_nights).must_equal [Date.new(2000, 1, 8), Date.new(2000, 1, 9)]

    room.book(nights: [Date.new(2000, 1, 14), Date.new(2000, 1, 15)])
    expect(room.booked_nights.length).must_equal 4
    expect(room.booked_nights).must_equal [Date.new(2000, 1, 8), Date.new(2000, 1, 9), Date.new(2000, 1, 14), Date.new(2000, 1, 15)]
  end
end
