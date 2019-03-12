require_relative "spec_helper"

describe Hotel do
  it "should be an instance of the hotel" do
    hotel = Hotel.new
    expect(hotel).must_be_instance_of Hotel
  end
  it "has 20 rooms" do
    hotel = Hotel.new
    expect(hotel.rooms.length).must_equal 20
  end
end
