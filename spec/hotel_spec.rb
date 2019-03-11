require_relative "spec_helper"

describe "initialize" do
  it "returns an object of type Hotel" do
    hotel = Hotel.new
    expect(hotel).must_be_kind_of Hotel
  end
end
