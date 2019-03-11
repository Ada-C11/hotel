require 'spec_helper.rb'

describe "initialize" do
  it "is required" do 
    test_room = Room.new(15)
    expect(test_room).must_be_kind_of Room
  end
end