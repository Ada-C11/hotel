require_relative "spec_helper"

describe "FrontDesk class" do
  let(:frontdesk) {
    FrontDesk.new
  }

  it "is able to instantiate" do
    expect(frontdesk).must_be_kind_of FrontDesk
  end

  it "can pull up list of rooms" do
    expect(frontdesk.rooms).must_be_kind_of Array

    # Can I set this to be NUMBER_OF_ROOMS constant?
    expect(frontdesk.rooms.length).must_equal 20

    expect(frontdesk.rooms[0]).must_be_kind_of Room
  end
end
