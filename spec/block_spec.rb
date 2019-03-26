require_relative "spec_helper"

describe "Block class" do
  describe "initialize" do
    it "returns a block object" do
      block_id = 12
      room_ids = [1, 2, 3]
      reserved_dates = Hotel::TimeInterval.new(Date.parse("2019-12-03"), Date.parse("2019-12-04"))
      discounted_rate = 180
      expect(Hotel::Block.new(block_id, room_ids, reserved_dates, discounted_rate)).must_be_instance_of Hotel::Block
    end

    it "raises an error when more than 5 rooms are blocked out" do
      block_id = 12
      room_ids = [1, 2, 3, 4, 5, 6]
      reserved_dates = Hotel::TimeInterval.new(Date.parse("2019-12-03"), Date.parse("2019-12-04"))
      discounted_rate = 180
      expect {
        Hotel::Block.new(block_id, room_ids, reserved_dates, discounted_rate)
      }.must_raise Hotel::RoomNotAvailableError
    end
  end
end
