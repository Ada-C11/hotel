require_relative "spec_helper"

describe "Room class" do
  let(:room) { Room.new(1) }

  it "is able to instantiate" do
    expect(room).must_be_kind_of Room
  end

  it "can check if room is available" do
    expect(room.available?).must_equal true

    room.status = :UNAVAILABLE
    expect(room.available?).must_equal false
  end
end
