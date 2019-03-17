require_relative "spec_helper"
describe "Block" do
  it "creates a block" do
    start_date = Time.parse("2019-02-27 14:08:45 -0700")
    end_date = Time.parse("2019-02-28 14:08:45 -0700")
    rooms = [1, 4, 6, 16, 19]
    rate_discount = 10
    block = Hotel::Block.new(start_date, end_date, rooms, rate_discount)
    expect(block).must_be_instance_of Hotel::Block
    expect(block.start_date).must_be_instance_of Time
    expect(block.end_date).must_be_instance_of Time
    expect(block.rooms).must_be_instance_of Array
    expect(block.rate_discount).must_be_kind_of Integer
  end
end
# As a user of the hotel system,
# I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate OK
