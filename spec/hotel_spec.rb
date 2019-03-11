require_relative "spec_helper"

describe Hotel do
  it "should be an instance of the hotel" do
    hotel = Hotel.new
    expect(hotel).must_be_instance_of Hotel
  end
end
