require "time"

require_relative "spec_helper"

describe "Frontdesk.new" do
  it "creates and instance of Frontdesk" do
    frontdesk = Hotel::Frontdesk.new
    expect(frontdesk).must_be_instance_of Hotel::Frontdesk
  end

  it "creates a list of 20 rooms at the hotel" do
    frontdesk = Hotel::Frontdesk.new
    expect(frontdesk.rooms).must_be_instance_of Array
    expect(frontdesk.rooms.length).must_equal 20
    expect(frontdesk.rooms.first.number).must_equal 1
    expect(frontdesk.rooms.last.number).must_equal 20
  end
end
